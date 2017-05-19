module.exports = (robot) ->
	robot.respond /switch.sh/, (msg) ->
		@exec = require('child_process').exec
		command = "sh ./scripts/shell/stgSwitch.sh"
		msg.send "Command: #{command}"
		resp = ""
		@exec command, (error, stdout, stderr) ->
			resp += error if error?
			resp += stdout if stdout?
			resp += stderr if stderr?
			msg.send #{resp}
    msg.send "STG2面の接続先を、結合1環境に切り替えました"
