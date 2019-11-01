RSpec.describe Api.routes do
  it 'recognizes "POST /distance"' do
    env   = Rack::MockRequest.env_for('/distance', method: 'POST')
    route = described_class.recognize(env)

    expect(route.routable?).to be(true)

    expect(route.path).to eq('/distance')
    expect(route.verb).to eq('POST')
    expect(route.params).to eq({})
  end

  it 'recognizes "GET /cost"' do
    env   = Rack::MockRequest.env_for('/cost', method: 'GET')
    route = described_class.recognize(env)

    expect(route.routable?).to be(true)

    expect(route.path).to eq('/cost')
    expect(route.verb).to eq('GET')
    expect(route.params).to eq({})
  end
end
