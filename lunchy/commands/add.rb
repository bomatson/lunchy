require "redis"

module Lunchy
  module Commands
    class Add < SlackRubyBot::Commands::Base
      command 'add' do |client, data, _match|
        redis = Redis.new
        lunch_spot = data.text.split(/\s+/)[2..-1].join(' ')
        channel_name = data.channel
        response = ['Great', 'Amazing', 'Nicely done', 'That place rules', 'Into it', 'Good stuff', 'Excellent']

        unless lunch_spot.empty?
          redis.sadd(channel_name, lunch_spot)
          client.say(channel: channel_name, text: "#{response.sample}! I've added #{lunch_spot} to the list")
        else
          client.say(channel: channel_name, text: "Whoops! You need to include a restaurant name, silly")
        end
      end
    end
  end
end
