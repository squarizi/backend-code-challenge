RSpec.describe DijkstraGraph, type: :service do
  context '#shortest_path' do
    let(:graph) { [['A', 'B', 10], ['B', 'C', 15], ['A', 'C', 30]] }
    let(:service) { described_class.new(graph) }
    let(:origin) { 'A' }
    let(:destination) { 'C' }
    let(:result) { [['A', 'B', 'C'], 25] }

    it { expect(service.shortest_path(origin, destination)).to eq result }
  end
end
