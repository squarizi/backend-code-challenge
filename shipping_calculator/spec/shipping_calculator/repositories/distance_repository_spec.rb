RSpec.describe DistanceRepository, type: :repository do
  describe '#find_id_by_origin_and_destination?' do
    let(:repository) { DistanceRepository.new }

    context 'when distance does not exist' do
      let(:origin) { 'origin' }
      let(:destination) { 'destination' }

      it { expect(repository.find_id_by_origin_and_destination(origin, destination)).to be_nil}
    end

    context 'when distance does not exist' do
      let(:origin) { "A #{Time.now}" }
      let(:destination) { "B #{Time.now}" }
      let(:kilometers) { rand(1..10000) }
      let(:distance) { repository.create(origin: origin, destination: destination, kilometers: kilometers) }

      before { distance }

      it { expect(repository.find_id_by_origin_and_destination(origin, destination)).to eq distance.id }
    end
  end
end
