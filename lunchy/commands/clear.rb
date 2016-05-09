require "redis"

module Lunchy
  module Commands
    class Clear < SlackRubyBot::Commands::Base
      command 'clear' do |client, data, _match|
        redis = Redis.new
        redis.del data.channel

        client.say(channel: data.channel, text: "The lunch queue has been cleared!")
      end
    end
  end
end

