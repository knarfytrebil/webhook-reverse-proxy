WebSocket = require('ws')
ws = new WebSocket("ws://yo-ren.com:7070/theHooker")

ws.on 'open', ->
  ws.send 'something'
  ws.on 'message', (data, flags) ->
    msg = JSON.parse(data)
    if msg.object_kind == 'push'
      repo = msg.repository.name
      console.log "Push event caught from #{repo}"
      console.log "#{msg.commits.length} Commit(s)"
      msg.commits.forEach (c) ->
        if c.message.indexOf('@deploy') > -1
          console.log "Need to Deploy #{repo}"
    else
      console.log 'msg', msg
