# coding: utf-8
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

      TEST_EMAILS = [
        'sidney@carbonfive.com',
        'jon@carbonfive.com',
        'sueanna@carbonfive.com',
        'ericf@carbonfive.com',
        'suzanna@carbonfive.com',
        'bobby@carbonfive.com'
      ]

      def self.send_direct_message(client, user, msg)
        im = client.ims.values.detect { |i| i.user == user.id }
        channel = if im == nil
                    # start a new conversation with this user if necessary
                    response = client.web_client.im_open user: user.id
                    response.channel
                  else
                    im.id
                  end
        client.say(channel: channel, text: msg)
      end

      command 'nag' do |client, data, _match|
        emails = ENV['FOR_REALZ'] ? Timesheet.status : TEST_EMAILS
        users = client.users.values.select { |user| emails.include? user.profile.email }

        names = users.map{ |user| user.profile.first_name }

        client.say(channel: data.channel, text: "I just nagged these people about their hours: #{names.join(', ')}")

        users.each do |user|
          send_direct_message(client, user, "#{NagHelpers.random_nag} :yoda:\nhttps://timesheet.carbonfive.com\n")
        end
      end
    end
  end
end
