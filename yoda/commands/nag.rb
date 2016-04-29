class NagHelpers
  def self.random_nag
    [
      "Days it has been since hours I requested. To Timesheet go. Yeesssssss?",
      "Do or do not. There is no try.",
      "Excuses matter not. Hours you shall enter.",
      "Entered your hours must be, before banish these nags you can.",
      "Missing hours you have. Ignore you shall not.",
      "The dark path of not entering hours — consume you it will.",
      "Without hours entered, in a dark place we find ourselves.",
      "The fear of missing hours is a path to the Dark Side.",
      "Hours? Found some you have?",
      "No Timesheet you fill? Only pain you will find.",
      "Ready are you? Enter hours you will.",
      "Clear your mind will be, if enter hours you do.",
      "Think I am fooling, do you? Hours you must."
    ].sample
  end
end

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
          client.say(channel: channel, text: "#{NagHelpers.random_nag}")
        end
      end
    end
  end
end
