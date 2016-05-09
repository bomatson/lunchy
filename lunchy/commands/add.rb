require "redis"

module Lunchy
  module Commands
    class Add < SlackRubyBot::Commands::Base
      command 'add' do |client, data, _match|
        redis = Redis.new
        lunch_spot = data.text.split(/\s+/)[1..-1].join(' ')

        unless lunch_spot.empty?
          redis.lpush('lunch', lunch_spot)
          client.say(channel: data.channel, text: "Great! I've added #{lunch_spot} to the list")
        else
          client.say(channel: data.channel, text: "Whoops! You need to include a restaurant name, silly")
        end
      end
    end
  end
end
