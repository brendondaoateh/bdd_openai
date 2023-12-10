# frozen_string_literal: true

RSpec.describe BddOpenai::ErrorResponse do
  context 'when creating new instance' do
    describe '.from_json' do
      it 'creates instance from json' do
        expected_value = {
          error: {
            message: 'The requested assistant \'assistant_id\' does not exist.',
            type: 'invalid_request_error',
            param: 'assistant_id',
            code: 'assistant_not_found'
          }
        }
        input_json = expected_value.to_json
        file = described_class.from_json(input_json)

        expect(file).to have_attributes(expected_value[:error])
      end
    end

    describe '#initialize' do
      it 'creates instance from new with default value' do
        expected_value = {}
        file = described_class.new

        expect(file).to have_attributes(expected_value)
      end

      it 'creates instance from new with arguments' do
        expected_value = {
          message: 'The requested assistant \'assistant_id\' does not exist.',
          type: 'invalid_request_error',
          param: 'assistant_id',
          code: 'assistant_not_found'
        }
        file = described_class.new(expected_value)

        expect(file).to have_attributes(expected_value)
      end
    end
  end
end
