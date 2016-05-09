require 'spec_helper'

describe Lunchy::Bot do
  subject { Lunchy::Bot.instance }

  it_behaves_like 'a slack ruby bot'
end


