require 'giphy'

class YodaHelpers
  def self.generate_message(keywords)
    gif = begin
      Giphy.random(keywords)
    rescue StandardError => e
      logger.warn "Giphy.random: #{e.message}"
      nil
    end if SlackRubyBot::Config.send_gifs?
    text = [gif && gif.image_url.to_s].compact.join("\n")
    { text: text }
  end
end

module Yoda
  module Commands
    DEFAULT_TIMES = 10
    MAX_TIMES = 500
    CLEANUP_DELAY = 20
    class Bomb < SlackRubyBot::Commands::Base


      match /^!(.*)bomb(\s+\d+)?/ do |client, data, _match|
        times = _match[2].to_i
        times = times == 0 ? DEFAULT_TIMES : times
        if times > 500
          times = 500
        end
        bombing = if _match.nil?
                    'bomb'
                  else
                    _match[1]
                  end
        begin
          message_queue = Queue.new

          producer = Thread.new do
            times.times do
              message_options = YodaHelpers.generate_message(bombing).merge(channel: data.channel, as_user:true)
              message_queue << client.web_client.chat_postMessage(message_options)
            end
          end

          consumer = Thread.new do
            sleep(CLEANUP_DELAY)
            while message_queue.length > 0
              msg = message_queue.pop
              client.web_client.chat_delete(channel: msg.channel, ts: msg.ts)
            end
            message = "Dat was da bomb! :bomb: \n Now get back to work :c5:"
            client.say(channel: data.channel, text: message)
          end
          consumer.join

        rescue Exception => ex
          client.say(channel: data.channel, text: "You missed your target. Try again!")
          client.say(channel: data.channel, text: "/shrug")
        end
      end
    end
  end
end
