require_relative '../../../rack-way/router/route.rb'
require 'byebug'

RSpec.describe Rack::Way::Router::Route do
  it 'can match simple paths' do
    route = described_class.new '/test', double(call: 'Hey test')

    request =
      {
        'REQUEST_PATH' => '/test'
      }

    expect(route.match?(request)).to eq(true)
  end

  it 'can match path with params' do
    route =
      described_class
      .new '/test/:param1/test/:param2', double(call: 'Hey test')

    request =
      {
        'REQUEST_PATH' => '/test/1/test/2'
      }

    expect(route.match?(request)).to eq(true)
  end

  it 'donth match with wrong params' do
    route =
      described_class
      .new '/test/:param1/test/:param2', double(call: 'Hey test')

    request =
      {
        'REQUEST_PATH' => '/test/1/wrong/2'
      }

    expect(route.match?(request)).to eq(false)
  end
end
