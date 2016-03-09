WebSocket = require('ws')
ws = new WebSocket("ws://yo-ren.com:7070/theHooker")

ws.on 'open', ->
    ws.send 'something'
    ws.on 'message', (data, flags) ->
        msg = JSON.parse(data)
        console.log 'msg', msg
        console.log data
