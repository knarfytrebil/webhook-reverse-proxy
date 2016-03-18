// Generated by CoffeeScript 1.10.0
(function() {
  var WebSocket, ws;

  WebSocket = require('ws');

  ws = new WebSocket("ws://yo-ren.com:7070/theHooker");

  ws.on('open', function() {
    ws.send('something');
    return ws.on('message', function(data, flags) {
      var msg, repo;
      msg = JSON.parse(data);
      if (msg.object_kind === 'push') {
        repo = msg.repository.name;
        console.log("Push event caught from " + repo);
        console.log(msg.commits.length + " Commit(s)");
        return msg.commits.forEach(function(c) {
          if (c.message.indexOf('@deploy') > -1) {
            return console.log("Need to Deploy " + repo);
          }
        });
      } else {
        return console.log('msg', msg);
      }
    });
  });

}).call(this);
