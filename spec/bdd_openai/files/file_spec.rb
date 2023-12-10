# frozen_string_literal: true

RSpec.describe BddOpenai::Files::File do
  context 'when creating new instance' do
    it 'creates instance from new with default value' do
      expected_value = {}
      file = described_class.new

      expect(file).to have_attributes(expected_value)
    end

    it 'creates instance from new with arguments' do
      expected_value = {
        id: 'file-123',
        bytes: 1024,
        created_at: 123_456_789,
        filename: 'file.txt',
        object: 'file',
        purpose: 'assistants'
      }
      file = described_class.new(expected_value)

      expect(file).to have_attributes(expected_value)
    end

    it 'creates instance from json' do
      expected_value = {
        id: 'file-123',
        bytes: 1024,
        created_at: 123_456_789,
        filename: 'file.txt',
        object: 'file',
        purpose: 'assistants'
      }
      input_json = expected_value.to_json
      file = described_class.from_json(input_json)

      expect(file).to have_attributes(expected_value)
    end
  end
end
