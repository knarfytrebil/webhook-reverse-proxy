WebhookServer = require('simplewebhook')
WebSocketServer = require('ws').Server

wss = new WebSocketServer
  port: 7070

server = WebhookServer
  serverType: 'gitlab'

wss.on 'connection', (ws) ->
  # Server Hook for Specific Project
  server.addHook
    # Feel free to change the name here
    link: '/theHooker'
    event: '*'
    exec: 'ls -la'
    options: encoding: 'utf8'
    handler: (error, stdout, stderr) ->
      ws.send @request.body
      console.log 'Request body :', @request.body
      console.log 'List command: ', stdout
      @response.send 'Hello'
      return

  ws.on 'message', incoming(message) ->
    console.log('received: %s', message)

  ws.send('Welcome to Webhook Proxy ...')

# Webhook Server Listens to Port 3333
server.listen 3333
