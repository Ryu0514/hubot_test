# Description:
#   simple time tracker.
#
# Commands:
#   now <text> - save datetime, <text>
#   hubot today - export all todays datetime, <text>

# 時刻を受け取ってYYYY-mm-dd形式で返す
toYmdDate = (date) ->
  Y = date.getFullYear()
  m = ('0' + (date.getMonth() + 1)).slice(-2)
  d = ('0' + date.getDate()).slice(-2)
  return "#{Y}-#{m}-#{d}"

# 時刻を受け取ってhh:mm形式で返す
tohhmmTime = (date) ->
  hh = ('0' + date.getHours()).slice(-2)
  mm = ('0' + date.getMinutes()).slice(-2)
  return "#{hh}:#{mm}"

module.exports = (robot) ->
  # keyを設定
  key = "timeTracker"

  # hubot now <test> に反応させる
  robot.respond /start (.*)/i, (msg) ->
    # 発言から内容を取得。date,text,userの3つ
    date = new Date
    text = msg.match[1]
    user = msg.message.user.name
    robot.logger.debug "fetch message from #{user}"
    tasks = robot.brain.get(key) ? []
    task = { user: user, date: toYmdDate(date), time: tohhmmTime(date), task: text }
    tasks.push task
    robot.brain.set key, tasks
    robot.logger.debug "receive #{text} from #{user}"
    #msg.reply "task saved! #{tohhmmTime(date)} #{text}"
    msg.send "task saved! #{tohhmmTime(date)} #{text}"

  robot.respond /today$/, (msg) ->
    date = new Date
    user = msg.message.user.name
    tasks = robot.brain.get(key) ? []
    message = "本日#{user}さんが行ったタスクは"
    message = message + tasks.filter (task) ->
      task.date == toYmdDate(date)
    .filter (task) ->
      task.user == user
    .map (task) ->
      "#{task.time} #{task.task}"
    .join '\n'
    robot.logger.debug "receive #{message} from #{user}"
    msg.reply "#{message}"

