RSpec.describe Api::Controllers::Distance::Receive do
  include Rack::Test::Methods

  let(:app) { Hanami.app }
  let(:action) { Api::Controllers::Distance::Receive.new }

  context "when have errors" do
    let(:params) { '' }
    let(:error) { "{\"message\":{\"origin\":[\"must be filled\"],\"destination\":[\"must be filled\"],\"kilometers\":[\"must be greater than 0\"]}}" }

    it do
      post '/distance', params

      expect(last_response.status).to be(400)
      expect(last_response.body).to eq error
    end
  end

  context 'success' do
    let(:time) { (Time.now.to_i % 4_000) * 2 }
    let(:origin) { "A_#{time}" }
    let(:destination) { "B_#{time}" }
    let(:kilometers) { rand(1..10000) }

    context 'when distance is create' do
      let(:params) { "#{origin}_created #{origin}_created #{kilometers}" }
      let(:message) { "{\"message\":\"Created\"}" }

      it do
        post '/distance', params

        expect(last_response.status).to be(201)
        expect(last_response.body).to eq message
      end
    end

    context 'when distance is create' do
      let(:params) { "#{origin}_updated #{origin}_updated #{kilometers}" }
      let(:message) { "{\"message\":\"Updated\"}" }

      before { DistanceRepository.new.create(origin: "#{origin}_updated", destination: "#{origin}_updated", kilometers: kilometers) }

      it do
        post '/distance', params

        expect(last_response.status).to be(200)
        expect(last_response.body).to eq message
      end
    end
  end
end
