require 'spec_helper'

describe Yoda::Bot do
  subject { Yoda::Bot.instance }

  it_behaves_like 'a slack ruby bot'
end


