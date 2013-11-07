# export function for listening to the socket
module.exports = (socket) =>
  socket.on "init", (data) ->
    console.log "client connected, yeah"    
    matrix = [
        [1,2,3],
        [1,2,3],
        [1,2,3]
    ]

    socket.emit "matrix",
      matrix: matrix

  socket.on "disconnect", =>

        

