WebhookServer = require('simplewebhook')
WebSocketServer = require('ws').Server

wss = new WebSocketServer({ port: 7070 })
server = WebhookServer(serverType: 'gitlab')

wss.on 'connection', (ws) ->
  ws.on 'message', incoming(message) ->
    console.log('received: %s', message)
  ws.send('something')

server.addHook
  link: '/'
  event: '*'
  exec: 'ls -la'
  options: encoding: 'utf8'
  handler: (error, stdout, stderr) ->
    console.log 'Request body :', @request.body
    console.log 'List command: ', stdout
    @response.send 'Hello'
    return
server.listen 3333