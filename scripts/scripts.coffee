module.exports = (robot) ->

    # 単純な応答: respond
    robot.respond /I am (.*)/i, (msg) ->
        msg.send "Hi, #{msg.match[1]}"

    # 呼ばれなくても発言に反応: hear
    robot.hear /今何時/, (msg) ->
        msg.send new Date()

    # scriptの実行
    robot.respond /sh (.+)/, (msg) ->
        file = msg.match[1].trim()
        if /(^\.|\/)/.exec(file)
            msg.send 'Error: File name must not have "/" and must not start with "."'
            return

        @exec = require('child_process').exec
        command = "sh ./scripts/shell/#{file}"

        @exec command, (err, stdout, stderr) ->
            resp = ""
            resp +=    err if    err?
            resp += stdout if stdout?
            resp += stderr if stderr?
            msg.send """[info][title]execute: #{command}[/title]#{resp}[/info]"""
