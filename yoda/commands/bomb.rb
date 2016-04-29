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
    CLEANUP_DELAY = 10
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
          messages = []
          times.times do
            message_options = YodaHelpers.generate_message(bombing).merge(channel: data.channel, as_user:true)
            messages << client.web_client.chat_postMessage(message_options)
          end

          Thread.new do
            sleep(CLEANUP_DELAY)
            messages.each do |msg|
              client.web_client.chat_delete(channel: msg.channel, ts: msg.ts)
            end
          end
        rescue Exception => ex

          client.say(channel: data.channel, text: "#{ex} :bomb:")
        end
      end
    end
  end
end
