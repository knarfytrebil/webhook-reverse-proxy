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
    exec: 'time'
    options: encoding: 'utf8'
    handler: (error, stdout, stderr) ->
      # ws.send @request.body
      ws.send 'wtf'
      console.log 'Request body :', JSON.stringify(@request.body)
      console.log 'List command: ', stdout
      @response.send 'Hello'
      return

  ws.on 'message', (message) ->
    console.log('received: %s', message)

  ws.send('Welcome to Webhook Proxy ...')

# Webhook Server Listens to Port 3333
server.listen 3333
