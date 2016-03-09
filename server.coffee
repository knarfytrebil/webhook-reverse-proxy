WebhookServer = require('simplewebhook')
WebSocketServer = require('ws').Server

wss = new WebSocketServer
  port: 7070

server = WebhookServer
  serverType: 'gitlab'

wss.broadcast = (data) ->
  wss.clients.forEach (client) ->
    client.send(data)

wss.on 'connection', (ws) ->
  # Server Hook for Specific Project
  server.addHook
    # Feel free to change the name here
    link: '/theHooker'
    event: '*'
    exec: 'time'
    options: encoding: 'utf8'
    handler: (error, stdout, stderr) ->
      wss.broadcast JSON.stringify(@request.body)
      console.log 'Request body :', @request.body
      console.log 'List command: ', stdout
      @response.send 'Hello'
      return

  ws.on 'message', (message) ->
    console.log('received: %s', message)

  ws.send JSON.stringify
    msg : 'Welcome to Webhook Proxy ...'

# Webhook Server Listens to Port 3333
server.listen 3333
