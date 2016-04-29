class RemindHelpers
  def self.reminder_attachment
    {
      "attachments": [
        {
          "fallback": "https://timesheet.carbonfive.com",
          "color": "#36a64f",
          "title": "Enter your hours in Timesheet",
          "pretext": "#{self.random_reminder}",
          "title_link": "https://timesheet.carbonfive.com",
          "mrkdwn_in": ["pretext"]
        }
      ]
    }
  end

  def self.random_reminder
    [
      "The force is strong today. Hours you will enter.",
      "Powerful you have become. Entered hours I sense from you."
    ].sample
  end
end

module Yoda
  module Commands
    class Remind < SlackRubyBot::Commands::Base
      command 'remind' do |client, data, _match|
        channel_name = 'team-eight'
        channels = client.channels.values + client.groups.values
        channel = channels.detect { |channel| channel.name == channel_name }

        message_options = {channel: channel.id, is_user: true}.merge(RemindHelpers.reminder_attachment)
        client.web_client.chat_postMessage(message_options)
      end
    end
  end
end
