# GroupMe @all

@all is a GroupMe chat bot built on [Hubot][hubot]. It was configured to be
deployed on [Heroku][heroku] to get you up and running as quick as possible.

[heroku]: http://www.heroku.com
[hubot]: http://hubot.github.com


## Features

Mention (tag) everyone in your group at once!

Blacklist users who don't need notifications.

Deploy to heroku easily!


### Deploying to Heroku

1. Fork the repository to your GitHub account
2. Log in to Heroku
3. Create a new app
4. Deploy from your GitHub and select the repo
5. Configure environment variables (and optionally Redis)


### Configuration

Start by configuring the environment variables below:

- HUBOT_GROUPME_TOKEN
- HUBOT_GROUPME_ROOM_ID
- HUBOT_GROUPME_BOT_ID

And optionally configure a Redis server for blacklist persistence.


### Running

Once configured, you can run the bot with `./bin/hubot -a groupme`. 

You should now be able to open the GroupMe room you've chosen and tag everyone in the group by mentioning @all!


## For more help

Since this is one of my most popular repos, I wrote a [blog post](https://hawkins.github.io/2016/10/11/groupme-at-all/) on configuring and extending this project. Please check this out if you have trouble! Finally, I'm always happy to help you with any other troubles that may come up. Please either [open a new issue](https://github.com/hawkins/groupme-at-all/issues/new) or [send me an email :)](mailto:hawkinswritescode@gmail.com)
