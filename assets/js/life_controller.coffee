'use strict'
app = angular.module('app')

app.controller 'LifeController', ($scope, socket) ->
  $scope.matrix = [
     [0,0,0],   
     [0,0,0],   
     [0,0,0]
  ]

  $scope.toggle = (row, index) ->
    console.log "toggle"
    row[index] = (row[index] + 1) % 2      

  $scope.pause_changed = ->
    unless $scope.paused
      console.log "overwriting matrix!"
      socket.emit "setMatrix",
        matrix: $scope.matrix

  # Socket listeners
  # ================
  socket.on 'connect', ->
    console.log "we are connected"    
    $('#no-connection').fadeOut();

    socket.emit 'start'

  socket.on 'disconnect', ->
    $('#no-connection').fadeIn();

  socket.on 'matrix', (data) ->
    console.log "we received new data"
    $scope.matrix = data.matrix unless $scope.paused
        
