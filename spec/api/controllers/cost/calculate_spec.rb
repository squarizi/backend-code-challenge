RSpec.describe Api::Controllers::Cost::Calculate do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:action) { Api::Controllers::Cost::Calculate.new }

  context "when have validate errors" do
    let(:error) { "{\"message\":{\"origin\":[\"must be filled\"],\"destination\":[\"must be filled\"],\"weight\":[\"must be greater than 0\"]}}" }

    it do
      get '/cost'

      expect(last_response.status).to be(400)
      expect(last_response.body).to eq error
    end
  end

  context "when origin or destination does not exist" do
    let(:origin) { 'origin' }
    let(:destination) { 'destination' }
    let(:weight) { 10 }
    let(:params) { "?origin=#{origin}&destination=#{destination}&weight=#{weight}" }
    let(:error) { "{\"message\":\"origin or destination does not exists\"}" }

    it do
      get "/cost#{params}"

      expect(last_response.status).to be(422)
      expect(last_response.body).to eq error
    end
  end
end
