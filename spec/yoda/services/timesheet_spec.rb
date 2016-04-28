require 'spec_helper'

describe Timesheet do
  let(:response) do
    {
      'worst_offenders' => {
        'jon@carbonfive.com' => [ Date.today.to_s ],
        'bob@carbonfive.com' => [ Date.today.to_s ],
      }
    }
  end

  before do
    allow(HTTParty).to receive(:get).and_return( double( body: response) )
  end

  it 'works' do
    expect(Timesheet.status).to eq ['jon@carbonfive.com', 'bob@carbonfive.com'] 
  end
end
