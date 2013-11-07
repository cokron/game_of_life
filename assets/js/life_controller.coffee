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

  redim = ->
    m = $scope.matrix
    l = m.length
    dim = $scope.dim

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
    console.log "we received new data"
    $scope.matrix = data.matrix unless $scope.paused
        
