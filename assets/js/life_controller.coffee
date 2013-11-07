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
    $('#no-connection').fadeOut();

  socket.on 'disconnect', ->
    $('#no-connection').fadeIn();

  socket.on "matrix", (data) ->
    $scope.matrix = data.matrix
        
