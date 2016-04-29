module Yoda
  module Commands
    class Remind < SlackRubyBot::Commands::Base
      command 'remind' do |client, data, _match|
        channel_name = 'team-eight'
        channels = client.channels.values + client.groups.values
        channel = channels.detect { |channel| channel.name == channel_name }

        client.say(channel: channel.id, text: 'fill in your hours, you must')
      end
    end
  end
end

