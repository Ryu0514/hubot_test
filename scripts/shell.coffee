module.exports = (robot) ->
	robot.respond /switch.sh (.*)/i, (msg) ->
		@exec = require('child_process').exec
		command = "sh ./scripts/shell/switch.sh"
		msg.send "Command: #{command}  STG2面の接続先を結合1環境に変更しました"
		resp = ""
		@exec command, (error, stdout, stderr) ->
			resp += error if error?
			resp += stdout if stdout?
			resp += stderr if stderr?
			msg.send #{resp}
