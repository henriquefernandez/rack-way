require_relative '../../../rack-way/router/build_request.rb'
require 'byebug'

RSpec.describe Rack::Way::Router::BuildRequest do
  it 'can build an Rack::Request' do
    request = described_class.new({}).call
    expect(request.class).to eq(Rack::Request)
  end

  context 'given a route with params' do
    let(:rack_request) do
      double(
        path: '/test/1/test/2',
        update_param: true
      )
    end

    it 'it can match the route params' do
      route =
        Rack::Way::Router::Route
          .new '/test/:param1/test/:param2', double(call: 'Hey test')

      allow(Rack::Request)
        .to(
          receive(:new)
          .and_return(rack_request)
        )

      expect(rack_request).to receive(:update_param).with(:param1, 1)
      expect(rack_request).to receive(:update_param).with(:param2, 2)

      described_class.new({}).call(route)
    end
  end
end
