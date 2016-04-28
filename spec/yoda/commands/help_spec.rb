require 'spec_helper'

describe Yoda::Commands::Help do
  def app
    Yoda::Bot.instance
  end

  it 'help' do
    expect(message: "#{SlackRubyBot.config.user} help").to respond_with_slack_message('no')
  end
end
