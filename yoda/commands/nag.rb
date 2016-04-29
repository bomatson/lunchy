module Yoda
  module Commands
    class Nag < SlackRubyBot::Commands::Base
      command 'nag' do |client, data, _match|
        #emails = Timesheet.status
        emails = ['sidney@carbonfive.com', 'jon@carbonfive.com', 'sueanna@carbonfive.com', 'ericf@carbonfive.com', 'suzanna@carbonfive.com', 'bobby@carbonfive.com']

        users = client.users.values.select { |user| emails.include? user.profile.email }

        names = users.map{ |user| user.profile.first_name }

        client.say(channel: data.channel, text: "nagging these people about their hours: #{names.join(', ')}")

        users.each do |user|
          im = client.ims.values.detect { |im| im.user == user.id }
          channel = if im == nil
            response = client.web_client.im_open user: user.id
            response.channel
          else
            im.id
          end
          client.say(channel: channel, text: "fill in your hours, you must")
        end
      end
    end
  end
end
