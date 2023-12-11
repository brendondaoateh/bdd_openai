# frozen_string_literal: true

RSpec.describe BddOpenai::Mapper::File do
  let(:sample_file_hash) do
    {
      id: 'file-123',
      bytes: 1024,
      created_at: 123_456_789,
      filename: 'file.txt',
      object: 'file',
      purpose: 'assistants'
    }
  end
  let(:sample_file_json) { sample_file_hash.to_json }

  describe '::from_json' do
    it 'creates instance from json' do
      file = described_class.from_json(sample_file_json)
      expect(file).to have_attributes(sample_file_hash)
    end
  end

  describe '#initialize' do
    it 'creates instance from new with default value' do
      file = described_class.new
      expect(file).to have_attributes({})
    end

    it 'creates instance from new with arguments' do
      file = described_class.new(sample_file_hash)
      expect(file).to have_attributes(sample_file_hash)
    end
  end
end
