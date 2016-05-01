class RemindHelpers
  def self.reminder_attachment
    {
      "attachments": [
        {
          "fallback": "https://timesheet.carbonfive.com",
          "title": "Go to Timesheet",
          "pretext": "<!channel>: #{self.random_reminder} :yoda:",
          "title_link": "https://timesheet.carbonfive.com",
          "mrkdwn_in": ["pretext"]
        }
      ]
    }
  end

  def self.random_reminder
    [
      "Our force is strong today. Hours you will enter.",
      "Powerful you have become. Entered hours I sense from you."
    ].sample
  end
end

module Yoda
  module Commands
    class Remind < SlackRubyBot::Commands::Base
      command 'remind' do |client, data, match|
        arg = data.text.split(/\s+/)[-1]
        channel_name = if arg != 'remind'
                         arg
                       else
                         'general'
                       end

        channels = client.channels.values + client.groups.values
        channel = channels.detect { |channel| channel.name == channel_name }

        message_options = {channel: channel.id, as_user: true}.merge(RemindHelpers.reminder_attachment)
        client.web_client.chat_postMessage(message_options)
        client.say(channel: data.channel, text: "Reminded the Jedis in ##{channel_name}, I have.  May the force be with them.")
      end
    end
  end
end
