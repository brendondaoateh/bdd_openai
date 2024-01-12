# frozen_string_literal: true

RSpec.describe BddOpenai::ErrorResponse do
  let(:sample_error_response) do
    {
      message: 'The requested assistant \'assistant_id\' does not exist.',
      type: 'invalid_request_error',
      param: 'assistant_id',
      code: 'assistant_not_found'
    }
  end
  let(:sample_error_json) { { error: sample_error_response }.to_json }

  describe '::from_json' do
    it 'creates instance from json' do
      file = described_class.from_json(sample_error_json)
      expect(file).to have_attributes(sample_error_response)
    end
  end

  describe '#initialize' do
    it 'creates instance from new with default value' do
      file = described_class.new
      expect(file).to have_attributes({})
    end

    it 'creates instance from new with arguments' do
      file = described_class.new(sample_error_response)
      expect(file).to have_attributes(sample_error_response)
    end
  end
end
