# Dependencies
express = require("express")
routes = require("./routes")
http = require('http')
socket = require('./routes/socket')
app = module.exports = express()

app.use require('connect-assets')()
server = http.createServer(app)

# Hook Socket.io into Express
io = require('socket.io').listen(server)

# Configuration
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(__dirname + "/public")
  app.use app.router

# Routes
app.get "/", routes.index
app.get "/partials/:name", routes.partials

# redirect all others to the index (HTML5 history)
app.get "*", routes.index

# Socket.io Communication
io.sockets.on('connection', socket)

# Start server
port = process.env.PORT || 3000
server.listen port, ->
  console.log "Express server listening on port " + port

# Handle the signal interupt (ctrl+c) to stop all works and exit.
#
# ------------------------------------------------------------------------------
process.on "SIGINT", ->
  console.log "Stop Game of Life server..."
  process.exit(0)

