# export function for listening to the socket

Life = require("#{__dirname}/../life").Life

class Runner
  matrix = [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,1,0,0],
        [0,0,1,0,0],
        [0,0,0,0,0],
        ]
  life = new Life(matrix)

  constructor: () ->
    @sockets = []
    @speed = 500

  start: ->
    @interval_handle = setInterval =>
      life.iterate()
      for socket in @sockets
        socket.emit "matrix",
          matrix: life.matrix
    , @speed

  setSpeed: (speed) ->
    console.log "set new speed: #{speed}"
    clearInterval(@interval_handle)
    @speed = speed
    @start()

  setMatrix: (matrix) ->
    life.matrix = matrix

  register: (socket)->
    @sockets.push(socket)

runner = new Runner()
runner.start()

module.exports = (socket) =>

  matrix = [
      [1,2,3],
      [1,2,3],
      [1,2,3]
  ]

  socket.on "start", =>
    console.log "client connected, yeah"
    runner.register(socket)

  socket.on "setNewParams", (data) =>
    console.log "set new params called"
    runner.setMatrix(data.matrix)
    runner.setSpeed(data.speed)
