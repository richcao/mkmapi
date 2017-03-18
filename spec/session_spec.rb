require 'spec_helper'

describe Mkmapi::Session do

  let(:connection) { double :connection, url_prefix: 'https://sandbox.mkmapi.eu/ws/v2.0/output.json' }
  let(:agent) { double :agent }

  before :each do
    allow(Mkmapi::Agent).to receive(:new).and_return(agent)
  end

  it 'gets itself an agent' do
    expect(Mkmapi::Agent).to receive(:new).with(connection, {})
    described_class.new connection, {}
  end

  it 'returns an Marketplace with the agent assigned' do
    marketplace = described_class.new(connection, {}).marketplace
    expect(marketplace).to be_an(Mkmapi::Marketplace)
    expect(marketplace.agent).to be(agent)
  end

end
