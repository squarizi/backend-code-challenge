RSpec.describe CostValidator, type: :validator do

  shared_examples 'cost validator' do |origin, destination, weight, success, errors|
    let(:validator) { described_class.new(origin: origin, destination: destination, weight: weight) }

    it { expect(validator.validate.success?).to eq success }
    it { expect(validator.validate.errors).to eq errors }
  end

  context 'all attributes' do
    context 'when does not have errors' do
      include_examples 'cost validator', 'A', 'B', 30, true, {}
    end

    context 'when all attribute should be filled' do
      filled_message = ['must be filled']

      include_examples 'cost validator', '', '', nil, false, {origin: filled_message, destination: filled_message, weight: filled_message}
    end
  end

  context '#origin and destination' do
    context 'when must be a string' do
      string_message = ['must be a string']

      include_examples 'cost validator', 2, 3, 30, false, {origin: string_message, destination: string_message}
    end

    context 'when length must be within 1 - 60' do
      size_message = ['length must be within 1 - 60']
      string_value_error = 'This is a big string with more than sixty characteres to get an error in Distance Validator'

      include_examples 'cost validator', string_value_error, string_value_error, 30, false, {origin: size_message, destination: size_message}
    end
  end

  context '#weight' do
    context 'when must be an integer' do
      include_examples 'cost validator', 'A', 'B', '30', false, {weight: ['must be an integer']}
    end

    context 'when must be greater than or equal to 0' do
      include_examples 'cost validator', 'A', 'B', -1, false, {weight: ['must be greater than 0']}
    end

    context 'when must be less than or equal to 50' do
      include_examples 'cost validator', 'A', 'B', 51, false, {weight: ['must be less than or equal to 50']}
    end
  end
end
