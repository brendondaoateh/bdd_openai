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

      def upload_file(purpose, file_path)
        uri = URI.parse("#{@openai_api_domain}/files")
        body, boundary = @http_client.create_multipart_body({ purpose: purpose }, { file: file_path })
        headers = default_headers
                  .merge({
                           "Content-Type": "multipart/form-data; boundary=#{boundary}"
                         })
        response = @http_client.call_post(uri, body, headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        BddOpenai::Files::File.from_json(response.body)
      end

      def delete_file(file_id)
        uri = URI.parse("#{@openai_api_domain}/files/#{file_id}")
        response = @http_client.call_delete(uri, default_headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        true
      end

      def retrieve_file(file_id)
        uri = URI.parse("#{@openai_api_domain}/files/#{file_id}")
        response = @http_client.call_get(uri, default_headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        BddOpenai::Files::File.from_json(response.body)
      end
    end
  end
end
