'use strict'
app = angular.module('app')

app.controller 'LifeController', ($scope, socket) ->
  # Socket listeners
  # ================
  socket.on 'connect', ->
    $('#no-connection').fadeOut();

  socket.on 'disconnect', ->
    $('#no-connection').fadeIn();

  socket.on "matrix", (data) ->
    $scope.matrix = data.matrix
        
