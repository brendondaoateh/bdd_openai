# frozen_string_literal: true

RSpec.describe BddOpenai::Files::Client do
  describe '#list_files' do
    context 'with invalid api key' do
      VCR.use_cassette('list_files_invalid_key') do
        api_key = 'invalid_key'
        client = described_class.new(api_key)
        result = client.list_files

        it 'returns an error response object' do
          expected_response = {
            message: "Incorrect API key provided: #{api_key}. You can find your API key at https://platform.openai.com/account/api-keys.",
            type: 'invalid_request_error',
            code: 'invalid_api_key'
          }
          expect(result).to have_attributes(expected_response)
        end
      end
    end

    context 'with valid api key' do
      VCR.use_cassette('list_files_valid_key') do
        api_key = ENV['OPENAI_API_KEY']
        client = described_class.new(api_key)
        result = client.list_files

        it 'returns a files array' do
          expected_response = [
            {
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
end
