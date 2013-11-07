'use strict'
app = angular.module('app')

app.controller 'LifeController', ($scope, socket) ->
  $scope.matrix = [
     [0,0,0],   
     [0,0,0],   
     [0,0,0]
  ]

  

  # Socket listeners
  # ================
  socket.on 'connect', ->
    console.log "we are connected"    
    $('#no-connection').fadeOut();

  socket.on 'disconnect', ->
    $('#no-connection').fadeIn();

  socket.on "matrix", (data) ->
    console.log "we received new data"
    $scope.matrix = data.matrix
        
