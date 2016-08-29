
https = require 'https'

room_id = process.env.HUBOT_GROUPME_ROOM_ID
bot_id = process.env.HUBOT_GROUPME_BOT_ID
token = process.env.HUBOT_GROUPME_TOKEN

module.exports = (robot) ->
  blacklist = []

  saveBlacklist = () ->
    console.log 'Saving blacklist'
    robot.brain.set 'blacklist', blacklist
    robot.brain.save()

  loadBlacklist = () ->
    blacklist = robot.brain.get 'blacklist'
    if blacklist
      console.log 'Blacklist loaded successfully'
    else
      console.warn 'Blacklist failed to load'

  addToBlacklist = (item) ->
    blacklist.push item
    saveBlacklist()

  removeFromBlacklist = (item) ->
    index = blacklist.indexOf item
    console.log "Found #{item} at #{index}"
    if index != -1
      blacklist.splice index, 1
      saveBlacklist()
    else
      console.warn "Unable to find #{item}"

  getUserByName = (name) ->
    name = name.trim()
    if name[0] == "@"
      name = name.slice 1
    user = robot.brain.userForName name
    unless user.user_id
      return null
    user

  getUserById = (id) ->
    user = robot.brain.userFOrId id
    unless user.user_id
      return null
    user

  robot.brain.once 'loaded', () ->
    loadBlacklist()

  robot.hear /get id (.*)/i, (res) ->
    """Get ID command"""
    target = res.match[1]
    console.log "Looking for user ID by name: #{target}"
    found = getUserByName target
    if found
      found = found.user_id
      console.log "Found ID #{found} by using #{target}"
      res.send "#{target}: #{found}"
    else
      res.send "Could not find a user with the name #{target}"

  robot.hear /get name (.*)/i, (res) ->
    """Get name command"""
    target = res.match[1]
    console.log "Looking for user name by ID: #{target}"
    found = getUserById target
    if found
      found = found.name
      console.log "Found name #{found} by using #{target}"
      res.send "#{target}: #{found}"
    else
      res.send "Could not find a user with the ID #{target}"

  robot.hear /view blacklist/i, (res) ->
    """View blacklist command"""
    res.send JSON.stringify blacklist

  robot.hear /blacklist (.*)/i, (res) ->
    """Blacklist command (expects name)"""
    target = res.match[1]
    user = getUserByName target
    if user
      console.log "Blacklisting #{target}"
      addToBlacklist user.user_id
      res.send "Blacklisted #{target} successfully"
    else
      res.send "Could not find a user by the name #{target}"

  robot.hear /whitelist (.*)/i, (res) ->
    """Whitelist command (expects name)"""
    target = res.match[1]
    user = getUserByName target
    if user
      console.log "Whitelisting #{target}"
      removeFromBlacklist user.user_id
      res.send "Whitelisted #{target} successfully"
    else
      res.send "Could not find a user by the name #{target}"

  robot.hear /(.*)@all(.*)/i, (res) ->
    """@all command"""
    text = res.match[0]
    users = robot.brain.users()

    if text.length < users.length
      text = "Please check the GroupMe, everyone."

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
