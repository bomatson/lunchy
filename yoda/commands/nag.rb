module Yoda
  module Commands
    class Nag < SlackRubyBot::Commands::Base
      command 'nag' do |client, data, _match|
        #emails = Timesheet.status
        emails = ['sidney@carbonfive.com']

        users = client.users.values.select { |user| emails.include? user.profile.email }

        puts users.inspect

        users.each do |user|
          im = client.ims.values.detect { |im| im.user == user.id }
          if im == nil
            response = client.web_client.im_open user: user.id
            puts "!!!!!!!!!!!!!!!!!!!!!"
            puts response.inspect
            puts im
            puts "!!!!!!!!!!!!!!!!!!!!!"
          end
          client.web_client.im_close channel_id: im.id
          client.say(channel: im.id, text: "fill in your hours, you must")
          client.say(channel: data.channel, text: "nagging #{user.profile.first_name} about their hours")
        end
      end
    end
  end
end
