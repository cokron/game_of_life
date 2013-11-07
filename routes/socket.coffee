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
    setInterval =>
      life.iterate()
      for socket in @sockets
        socket.emit "matrix",
          matrix: life.matrix
    , 500

  setMatrix: (matrix) ->
    life.matrix = matrix

  register: (socket)->
    @sockets.push(socket)      
  
runner = new Runner()

module.exports = (socket) =>

  matrix = [
      [1,2,3],
      [1,2,3],
      [1,2,3]
  ]

  socket.on "start", =>
    console.log "client connected, yeah"
    runner.register(socket)
        
  socket.on "setMatrix", (data)=>
    runner.setMatrix(data.matrix)
