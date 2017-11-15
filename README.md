# <img src="logo.png" width="128"> Unofficial GroupMe @all

**@all** is a third-party GroupMe chat bot built on [Hubot][hubot]. It was configured to be
deployed on [Heroku][heroku] to get you up and running as quick as possible.

[heroku]: http://www.heroku.com
[hubot]: http://hubot.github.com

> This project is not sponsored by, endorsed by, or managed by GroupMe. This is entirely a third-party project and is 100% open sourced. Use at your own risk.

> For questions or concerns, please contact the repository owner, not GroupMe.

## Features

Mention (tag) everyone in your group at once!

Blacklist users who don't need notifications.

Deploy to heroku easily!

## Using

In practice, users can simply write `@all` anywhere in their message to tag everyone in the group. The bot will repeat their message and tag everyone in the group in their repeated message.

You can also control a blacklist/whitelist via chat commands as well. This is a bit more advanced, so please review the source code yourself if you're interested to do this.

---

### Deploying to Heroku

1. Fork the repository to your GitHub account
    - And please star it to show your support. It's free for you and helps me a lot :yellow_heart:
2. Log in to Heroku
3. Create a new app
4. Deploy from your GitHub and select the repo
5. Configure environment variables (and optionally Redis)

If you're deploying via Heroku, you're done! :tada: The rest of this document is more specific to non-heroku users. See the end of the document if you need help.

---

## Manual setup

### Configuration

Start by configuring the environment variables below:

- `HUBOT_GROUPME_TOKEN`
- `HUBOT_GROUPME_ROOM_ID`
- `HUBOT_GROUPME_BOT_ID`

And optionally configure a Redis server for blacklist persistence.


### Running

Once configured, you can compile the bot with `npm run build` and then run the bot with `npm run start`.

You should now be able to open the GroupMe room you've chosen and tag everyone in the group by mentioning **@all**!

---

## For more help

Since this is one of my most popular repos, I wrote a [blog post](https://hawkins.is/writing-about/groupme-at-all) on configuring and extending this project. Please check this out if you have trouble! Finally, I'm always happy to help you with any other troubles that may come up. Please either [open a new issue](https://github.com/hawkins/groupme-at-all/issues/new) or [send me an email :)](mailto:hawkinswritescode@gmail.com)

---

powered by GroupMe®
