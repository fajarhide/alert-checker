#!/usr/bin/env ruby
# Alert System send to Telegram by. @fajarhide 2016
#

#include depedency
require 'rubygems'
require 'telegram/bot'
require 'net/http'

#set token your bot
token = 'YOUR_TELEGRAM_BOT_API_TOKEN'
Telegram::Bot::Client.run(token) do |bot |
bot.listen do |message |
    message.text = true
    #file list url
    File.open("text/url.txt", "r") do |file_read |
        file_read.each_line do |url |
            uri = URI(url)
            res = Net::HTTP.get_response(uri)
            #exclude respone header '200', because this for checker status header problem
    		if
				res.code != '200'
				bot.api.send_message(chat_id: message.chat.id, text: "#{uri} => #{res.code}\n")
            end
        end
    exit 1
    end
end
end
