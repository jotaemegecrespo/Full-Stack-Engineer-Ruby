require 'rails_helper'

RSpec.describe Marvel::Client do
  let(:base_url) { 'http://gateway.marvel.com' }
  let(:public_key) { '1234' }
  let(:private_key) { 'abcd' }
  let(:ts) { 1 }
  let(:expected_hash) { 'ffd275c5130566a2916217b101f26150' }

  before(:each) do
    stub_const('Marvel::Client::PUBLIC_KEY', public_key)
    stub_const('Marvel::Client::PRIVATE_KEY', private_key)
  end

  let(:client) { Marvel::Client.new(path, options) }

  describe 'get' do
    let(:path) { '/test/path' }
    let(:expected_response) { 'expected response' }

    let(:options) do
      {
        query: { test_parameter: 'test_value' }
      }
    end

    it 'makes an authenticated requestest to given path and paremters' do
      allow(client).to receive(:salt).and_return(ts)
      allow(Marvel::Client).to receive(:get).and_return(expected_response)
      response = client.get

      expect(Marvel::Client).to have_received(:get) do |path, options|
        expect(path).to eq path
        expect(options[:query]).to include(ts: 1)
        expect(options[:query]).to include(apikey: public_key)
        expect(options[:query]).to include(hash: expected_hash)
        expect(options[:query]).to include(test_parameter: 'test_value')
      end

      expect(response).to eq expected_response
    end
  end
end
