RSpec.describe CostService, type: :service do
  context '#calculate' do
    let(:graph) { [['A', 'B', 10], ['B', 'C', 15], ['A', 'C', 30]] }
    let(:origin) { 'A' }
    let(:destination) { 'C' }
    let(:weight) { 5 }
    let(:result) { 18.75 }

    before { allow(CostService).to receive(:formatted_distances).and_return(graph) }

    it { expect(described_class.calculate(origin, destination, weight)).to eq result }
  end
end
