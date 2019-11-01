RSpec.describe DistanceRepository, type: :repository do
  describe '#find_id_by_origin_and_destination?' do
    let(:repository) { DistanceRepository.new }

    context 'when distance does not exist' do
      let(:origin) { 'origin' }
      let(:destination) { 'destination' }

      it { expect(repository.find_id_by_origin_and_destination(origin, destination)).to be_nil}
    end

    context 'when distance exist' do
      let(:time) { Time.now.to_i % 6_000 }
      let(:origin) { "A #{time}" }
      let(:destination) { "B #{time}" }
      let(:kilometers) { rand(1..10000) }
      let(:distance) { repository.create(origin: origin, destination: destination, kilometers: kilometers) }

      before { distance }

      it { expect(repository.find_id_by_origin_and_destination(origin, destination)).to eq distance.id }
    end
  end

  describe '#exist_origin_or_destination?' do
    let(:repository) { DistanceRepository.new }

    context 'when origin or destination does not exist' do
      let(:origin) { 'origin' }
      let(:destination) { 'destination' }

      it { expect(repository.origin_or_destination_exist?(origin, destination)).to be_falsey}
    end

    context 'when origin or destination exist' do
      let(:time) { Time.now.to_i % 7_000 }
      let(:origin) { "A #{time}" }
      let(:destination) { "B #{time}" }
      let(:kilometers) { rand(1..10000) }
      let(:distance) { repository.create(origin: origin, destination: destination, kilometers: kilometers) }

      before { distance }

      it { expect(repository.origin_or_destination_exist?(origin, destination)).to be_truthy }
    end
  end
end
