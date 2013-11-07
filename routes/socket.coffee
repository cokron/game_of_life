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

  constructor: (socket) ->
    setInterval ->
      life.iterate()
      socket.emit "matrix",
        matrix: life.matrix
    , 1000

  setMatrix: (matrix) ->
    life.matrix = matrix    
  

module.exports = (socket) =>
  matrix = [
      [1,2,3],
      [1,2,3],
      [1,2,3]
  ]

  runner = `undefined`
  socket.on "start", =>
    console.log "client connected, yeah"
    runner = new Runner(socket)

        
  socket.on "setMatrix", (data)=>
    runner.setMatrix(data.matrix)
