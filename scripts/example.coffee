
https = require 'https'

room_id = process.env.HUBOT_GROUPME_ROOM_ID
bot_id = process.env.HUBOT_GROUPME_BOT_ID
token = process.env.HUBOT_GROUPME_TOKEN

# @all
default_message = "Please check the GroupMe, everyone."
blacklist = [
  '24719123', # Hunter
  '20449379', # Eli
  '16574902', # Daniel Lawson
  '20443083', # High Kyle
  '18514371', # Ryan Varner
  '20747530', # Jared
  '13984636'  # Dylan
]

# We evil now boys
# Prevent Heroku from dozing
setInterval () ->
  op =
    host: "hull-groupme-all.herokuapp.com"
    method: "GET"
  https.request op
, 300000

module.exports = (robot) ->
  robot.hear /(.*)@all(.*)/i, (res) ->
    text = res.match[0]
    users = robot.brain.users()

    if text.length < users.length
      text = default_message

    message =
      'text': text,
      'bot_id': bot_id,
      'attachments': [
        "loci": [],
        "type": "mentions",
        "user_ids": []
      ]

    i = 0
    for user, values of users
      if user in blacklist
        continue
      message.attachments[0].loci.push([i, i+1])
      message.attachments[0].user_ids.push(user)
      i += 1

    json = JSON.stringify(message)

    options =
      agent: false
      host: "api.groupme.com"
      path: "/v3/bots/post"
      port: 443
      method: "POST"
      headers:
        'Content-Length': json.length
        'Content-Type': 'application/json'
        'X-Access-Token': token

    req = https.request options, (response) ->
      data = ''
      response.on 'data', (chunk) -> data += chunk
      response.on 'end', ->
        console.log "[GROUPME RESPONSE] #{response.statusCode} #{data}"
    req.end(json)
