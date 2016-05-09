require "redis"

module Lunchy
  module Commands
    class Pick < SlackRubyBot::Commands::Base
      command 'pick' do |client, data, _match|
        redis = Redis.new
        decision = redis.lpop 'lunch'

        if decision
          client.say(channel: data.channel, text: "Time to eat! You are going to #{decision} :)")
        else
          client.say(channel: data.channel, text: "Shucks! It looks like there are no lunch spots in queue. Try adding a few!")
        end
      end
    end
  end
end

