module.exports = (robot) ->
	robot.respond /test_shell/, (msg) ->
		@exec = require('child_process').exec
		command = "sh ./scripts/shell/test.sh"
		msg.send "Command: #{command}"
		@exec command, (error, stdout, stderr) ->
			msg.send error if error?
			msg.send stdout if stdout?
			msg.send stderr if stderr?
