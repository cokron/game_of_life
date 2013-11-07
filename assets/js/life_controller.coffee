'use strict'
app = angular.module('app')

app.controller 'LifeController', ($scope, socket) ->
  $scope.matrix = [[0]]
  $scope.dim = 5

  redim = ->
    m = $scope.matrix
    l = m.length
    dim = $scope.dim
    console.log "redim from #{l} to #{dim}"

    if dim > l
      inflate = dim - l
      for i in [0..l-1]
        for j in [0..inflate-1]
          m[i].push(0)
      for i in [0..inflate-1]
        just0 = ->
          0
        m[l+i] = _.map [0..dim-1], just0
    else
      console.log "shrinking to " + dim
      m = _.head(m, dim)
      for i in [0..dim-1]
        console.log "shortening row " + i
        r = _.head(m[i], dim)
        console.log r
        m[i] = r
    $scope.matrix = m

  redim()

  $scope.toggle = (row, index) ->
    if $scope.paused
      console.log "toggle"
      row[index] = (row[index] + 1) % 2

  $scope.emptyMatrix = ->
    console.log "empty matrix"
    l = $scope.matrix.length - 1
    for i in [0..l]
      for j in [0..l]
        $scope.matrix[i][j] = 0 

  $scope.$watch 'paused', ->
    console.log "pause"
    unless $scope.paused
      console.log "overwriting matrix!"
      socket.emit "setMatrix",
        matrix: $scope.matrix
  , true


  $scope.$watch 'dim', ->
    redim()
  , true




  # Socket listeners
  # ================
  socket.on 'connect', ->
    console.log "we are connected"
    $('#no-connection').fadeOut();

    socket.emit 'start'

  socket.on 'disconnect', ->
    $('#no-connection').fadeIn();

  socket.on 'matrix', (data) ->
    unless $scope.paused
      console.log "we received new data"
      $scope.matrix = data.matrix
      $scope.dim = data.matrix.length
