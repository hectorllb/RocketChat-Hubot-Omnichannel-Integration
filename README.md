
# RocketChat-Hubot-Omnichannel-Integration
Integrate a chatbot in Hubot with a RocketChat to answer clients in livechat/omnichannel.
This chatbot will serve to answer customers in omnichannel and transfer them to other departments to be answered by a human




## Index

    1. Rocketchat Prerequisites
    2. Hubot-Rocketchat installation
    3. Chatbot creation


## 1. Rocketchat Prerequisites


- First we must have at least the STARTER version of Rocket.Chat.
- Omnichannel must be enabled \
- Create a User (call it bot or chatbot) without verified, with roles "_bot, LiveChat Agent, LiveChat Manager_" ![Captura de pantalla 2024-06-13 122959](https://github.com/hectorllb/RocketChat-Hubot-Omnichannel-Integration/assets/166048014/b10c1035-12f7-4aa7-9020-8bd9747a1f66)
- Now you need create a Department (**Administration --> Omnichannel --> Department**) for entry. ![image](https://github.com/hectorllb/RocketChat-Hubot-Omnichannel-Integration/assets/166048014/b12e8691-c393-4625-9404-13056503a531)
- Now you have to enable the user as an agent, to do this in **Administration --> Omnichannel --> Agents --> _'mybot'_ --> Available** ![Captura de pantalla 2024-06-13 123152](https://github.com/hectorllb/RocketChat-Hubot-Omnichannel-Integration/assets/166048014/9b6bee44-7c7e-4f64-9015-c32db1b98e66)
- Add _mybot_ to the Entry Department (**The bot only has to be in that department**)
    
## 2. Hubot-Rocketchat installation

**I follow this guide** \
https://github.com/RocketChat/hubot-rocketchat \
But here are my steps in case you want to use them.
- **Install 'Hubot' on the same machine as RocketChat**
    1. ```git clone https://github.com/RocketChat/hubot-rocketchat.git```
    2. ```cd hubot-rocketchat```
    3. ``` docker run -d -e ROCKETCHAT_URL=ipmachine:3000 -e ROCKETCHAT_ROOM='' -e RESPOND_TO_DM=true -e ROCKETCHAT_USER=username_bot -e ROCKETCHAT_PASSWORD=password_bot -e ROCKETCHAT_AUTH=password -e BOT_NAME=name(any) -e LISTEN_ON_ALL_PUBLIC=true -e RESPOND_TO_LIVECHAT=true -e EXTERNAL_SCRIPTS=hubot-pugme,hubot-help -v $PWD/scripts:/home/hubot/scripts rocketchat/hubot-rocketchat``` **the '-d' is for no debugging and start docker without stop**
    4. ```docker exec -it name_container /bin/bash```

## 3. Chatbot creation


### IMPORTANT
**In my case I have used a default bot that is installed in 'Hubot' called 'hubot-pugme' and in that I have modified its coffee file with a single script through which the bot works. Also you can create a new chatbot (see official documentation Hubot) this guide is modding Hubot-pugme**

### Creating chatbot
 1. ``` nano node_modules/hubot-pugme/src/pugme.coffee```
 2. ***Follow the file example for the bot (example_chatbot.coffee)***
 3. ```bin/hubot -a rocketchat --name bob > /dev/null 2>&1 &``` | **This is for exec the bot without debugging and run it on background**
 4. Now you can write in LiveChat Widget (in the Entry department) and and the bot will answer
![unnamed](https://github.com/hectorllb/RocketChat-Hubot-Omnichannel-Integration/assets/166048014/2a3de43e-9058-4f21-a1c7-b3b01cbc403f)



 



