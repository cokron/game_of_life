'use strict'
app = angular.module('app')

app.controller 'LifeController', ($scope, socket) ->
  $scope.paused = false
  $scope.init = false
  $scope.matrix = [[0,0],[0,2]]
  $scope.dim = 5
  $scope.preset = ""
  $scope.speed = 500

  matrix_util = new MatrixUtil
  $scope.matrix = matrix_util.redim($scope.matrix, $scope.dim)

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
    console.log "paused: #{$scope.paused} (init: #{$scope.init})"
    if !$scope.paused && $scope.init
      console.log "set new params!!"
      socket.emit "setNewParams",
        matrix: $scope.matrix
        speed: $scope.speed
  , true

  $scope.$watch 'preset', ->
    if $scope.paused
      console.log "preset: #{$scope.preset}"
      $scope.matrix = matrix_util.insert_preset $scope.matrix, $scope.preset

  $scope.$watch 'speed', ->
    console.log "speed: #{$scope.speed}"

  $scope.$watch 'dim', ->
    if $scope.init
      $scope.matrix = matrix_util.redim($scope.matrix, $scope.dim)
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
      $scope.init = true


# matrix utility
class MatrixUtil
  redim: (m, newdim) ->
    l = m.length
    dim = newdim
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
    m

  insert_preset: (m, preset) ->
    switch preset
      when "doppel-u"
        if m.length > 7
          x_start = Math.max(0, Math.floor(m.length / 2 - 1))
          y_start = Math.max(0, Math.floor(m.length / 2 - 3))
        else
          x_start = 0
          y_start = 0
        s = [
          [1,1,1],
          [1,0,1],
          [1,0,1],
          [0,0,0],
          [1,0,1],
          [1,0,1],
          [1,1,1],
        ]
        @stamp m, s, x_start, y_start
    m

  stamp: (m, stamp, x_start, y_start) ->
    for i in [0...stamp[0].length]
      for j in [0...stamp.length]
        @set_cell m, i + x_start, j + y_start, stamp[j][i]

  set_cell: (m, x, y, v) ->
    if x < m.length && y < m.length
      m[y][x] = v
