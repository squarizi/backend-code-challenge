RSpec.describe DistanceValidator, type: :validator do

  shared_examples 'distance validator' do |origin, destination, kilometers, success, errors|
    let(:validator) { described_class.new(origin: origin, destination: destination, kilometers: kilometers) }

    it { expect(validator.validate.success?).to eq success }
    it { expect(validator.validate.errors).to eq errors }
  end

  context 'all attributes' do
    context 'when does not have errors' do
      include_examples 'distance validator', 'A', 'B', 30, true, {}
    end

    context 'when all attribute should be filled' do
      filled_message = ['must be filled']

      include_examples 'distance validator', '', '', nil, false, {origin: filled_message, destination: filled_message, kilometers: filled_message}
    end
  end

  context '#origin and destination' do
    context 'when must be a string' do
      string_message = ['must be a string']

      include_examples 'distance validator', 2, 3, 30, false, {origin: string_message, destination: string_message}
    end

    context 'when length must be within 1 - 60' do
      size_message = ['length must be within 1 - 60']
      string_value_error = 'This is a big string with more than sixty characteres to get an error in Distance Validator'

      include_examples 'distance validator', string_value_error, string_value_error, 30, false, {origin: size_message, destination: size_message}
    end
  end

  context '#kilometers' do
    context 'when must be an integer' do
      include_examples 'distance validator', 'A', 'B', '30', false, {kilometers: ['must be an integer']}
    end

    context 'when must be greater than or equal to 0' do
      include_examples 'distance validator', 'A', 'B', -1, false, {kilometers: ['must be greater than 0']}
    end

    context 'when must be less than or equal to 100000' do
      include_examples 'distance validator', 'A', 'B', 10000000000000000, false, {kilometers: ['must be less than or equal to 100000']}
    end
  end
end
