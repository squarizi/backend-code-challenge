RSpec.describe Api::Controllers::Cost::Calculate do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:action) { Api::Controllers::Cost::Calculate.new }

  context "when have errors" do
    let(:params) { '' }
    let(:error) { "{\"message\":{\"origin\":[\"must be filled\"],\"destination\":[\"must be filled\"],\"weight\":[\"must be filled\"]}}" }

    it do
      get '/cost', params

      expect(last_response.status).to be(400)
      expect(last_response.body).to eq error
    end
  end
end
