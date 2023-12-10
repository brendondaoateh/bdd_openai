# frozen_string_literal: true

module BddOpenai
  # Module for OpenAI Files API
  # Ref: https://platform.openai.com/docs/api-reference/files
  module Files
    # Client for OpenAI Files API
    class Client
      def initialize(api_key = '')
        @http_client = BddOpenai::Client::HttpClient.new
        @openai_api_domain = 'https://api.openai.com/v1'
        @openai_api_key = api_key
      end

      def default_headers
        {
          "Authorization": "Bearer #{@openai_api_key}",
          "Content-Type": 'application/json'
        }
      end

      def list_files
        uri = URI.parse("#{@openai_api_domain}/files")
        response = @http_client.call_get(uri, default_headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        JSON.parse(response.body)['data'].map do |file|
          BddOpenai::Files::File.from_json(file.to_json)
        end
      end
    end
  end
end
