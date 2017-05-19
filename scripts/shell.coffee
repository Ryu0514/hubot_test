 module.exports = (robot) ->
	robot.respond /switch.sh/, (msg) ->
		@exec = require('child_process').exec
		command = "sh ./scripts/shell/test.sh"
		command = "sh ./scripts/shell/stgSwitch.sh"
		msg.send "Command: #{command}"
		resp = ""
		@exec command, (error, stdout, stderr) ->
