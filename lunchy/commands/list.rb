require "redis"

module Lunchy
  module Commands
    class List < SlackRubyBot::Commands::Base
      command 'list' do |client, data, _match|
        redis = Redis.new
        channel_name = data.channel
        list = redis.smembers(channel_name)

        unless list.empty?
          client.say(channel: channel_name, text: list.join(' | '))
        else
          client.say(channel: channel_name, text: "Whoops!! It looks like there are no lunch spots in queue. Try adding a few!")
        end
      end
    end
  end
end
