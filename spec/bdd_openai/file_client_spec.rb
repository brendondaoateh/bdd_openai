# frozen_string_literal: true

RSpec.describe(BddOpenai::FileClient) do
  let(:api_key) { ENV['OPENAI_API_KEY'] }
  subject(:client) { described_class.new(api_key) }

  describe '#list_files' do
    context 'with invalid api key' do
      it 'returns an error response object' do
        VCR.use_cassette('list_files_invalid_key') do
          invalid_key = 'invalid_key'
          client = described_class.new(invalid_key)
          result = client.list_files
          expected_response = {
            message: "Incorrect API key provided: #{invalid_key}. You can find your API key at https://platform.openai.com/account/api-keys.",
            type: 'invalid_request_error',
            code: 'invalid_api_key'
          }
          expect(result).to have_attributes(expected_response)
        end
      end
    end

    context 'with valid api key' do
      it 'returns a files array' do
        VCR.use_cassette('list_files_valid_key') do
          result = client.list_files
          expected_response = [
            {
              object: 'file',
              id: 'file-DKQD4iZvYfaqQ6Pfx8Yq7CZh',
              purpose: 'assistants',
              filename: 'sample.pdf',
              bytes: 2830,
              created_at: 1_702_269_196
            }, {
              object: 'file',
              id: 'file-0xnOZNQwNqWzPHFl3yeOIHgK',
              purpose: 'assistants',
              filename: 'sample.pdf',
              bytes: 3028,
              created_at: 1_702_244_298
            }
          ]

          expect(result).to be_an(Array)
          result.each_with_index do |element, index|
            expect(element).to have_attributes(expected_response[index])
          end
        end
      end
    end
  end

  describe '#upload_file' do
    context 'with invalid purpose' do
      it 'returns an error response object' do
        VCR.use_cassette('upload_file_invalid_purpose') do
          purpose = 'invalid_purpose'
          file_path = 'spec/fixtures/sample.pdf'
          result = client.upload_file(purpose, file_path)
          expected_response = {
            message: "'#{purpose}' is not one of ['fine-tune', 'assistants'] - 'purpose'",
            type: 'invalid_request_error'
          }
          expect(result).to have_attributes(expected_response)
        end
      end
    end

    context 'with valid purpose and file' do
      it 'returns file object of uploaded file' do
        VCR.use_cassette('upload_file_valid') do
          purpose = 'assistants'
          file_path = 'spec/fixtures/sample.pdf'
          result = client.upload_file(purpose, file_path)
          expected_response = {
            object: 'file',
            id: 'file-DKQD4iZvYfaqQ6Pfx8Yq7CZh',
            purpose: 'assistants',
            filename: 'sample.pdf',
            bytes: 2830,
            created_at: 1_702_269_196
          }
          expect(result).to have_attributes(expected_response)
        end
      end
    end
  end

  describe '#delete_file' do
    context 'with invalid file id' do
      it 'returns an error response object' do
        VCR.use_cassette('delete_file_invalid_id') do
          file_id = 'invalid_id'
          result = client.delete_file(file_id)
          expected_response = {
            "message": "No such File object: #{file_id}",
            "type": 'invalid_request_error',
            "param": 'id'
          }
          expect(result).to have_attributes(expected_response)
        end
      end
    end

    context 'with valid file id' do
      it 'returns true' do
        VCR.use_cassette('delete_file_valid') do
          file_id = 'file-Uoz8yzLCgamwaSLTklAT1PPA'
          result = client.delete_file(file_id)
          expect(result).to eq true
        end
      end
    end
  end

  describe '#retrieve_file' do
    context 'with invalid file id' do
      it 'returns an error response object' do
        VCR.use_cassette('retrieve_file_invalid_id') do
          file_id = 'invalid_id'
          result = client.retrieve_file(file_id)
          expected_response = {
            "message": "No such File object: #{file_id}",
            "type": 'invalid_request_error',
            "param": 'id'
          }
          expect(result).to have_attributes(expected_response)
        end
      end
    end

    context 'with valid file id' do
      it 'returns true' do
        VCR.use_cassette('retrieve_file_valid') do
          file_id = 'file-DKQD4iZvYfaqQ6Pfx8Yq7CZh'
          result = client.retrieve_file(file_id)

          expected_response = {
            object: 'file',
            id: 'file-DKQD4iZvYfaqQ6Pfx8Yq7CZh',
            purpose: 'assistants',
            filename: 'sample.pdf',
            bytes: 2830,
            created_at: 1_702_269_196
          }
          expect(result).to have_attributes(expected_response)
        end
      end
    end
  end
end
