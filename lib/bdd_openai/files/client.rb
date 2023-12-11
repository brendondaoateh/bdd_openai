# frozen_string_literal: true

module BddOpenai
  # Module for OpenAI Files API
  # Ref: https://platform.openai.com/docs/api-reference/files
  module Files
    # Client for OpenAI Files API
    class Client
      # @param api_key [String] The key of the OpenAI API
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

      # @return [Array<BddOpenai::Mapper::File>, BddOpenai::ErrorResponse]
      def list_files
        uri = URI.parse("#{@openai_api_domain}/files")
        response = @http_client.call_get(uri, default_headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        JSON.parse(response.body)['data'].map do |file|
          BddOpenai::Mapper::File.from_json(file.to_json)
        end
      end

      # @param purpose [String] The intended purpose of the file. One of: "fine-tune", "assistants".
      # @param file_path [String] The path of the file to upload
      # @return [BddOpenai::Mapper::File, BddOpenai::ErrorResponse]
      def upload_file(purpose, file_path)
        uri = URI.parse("#{@openai_api_domain}/files")
        body, boundary = @http_client.create_multipart_body({ purpose: purpose }, { file: file_path })
        headers = default_headers
                  .merge({
                           "Content-Type": "multipart/form-data; boundary=#{boundary}"
                         })
        response = @http_client.call_post(uri, body, headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        BddOpenai::Mapper::File.from_json(response.body)
      end

      # @param file_id [String] The id of the file to delete
      # @return [true, BddOpenai::ErrorResponse]
      def delete_file(file_id)
        uri = URI.parse("#{@openai_api_domain}/files/#{file_id}")
        response = @http_client.call_delete(uri, default_headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        true
      end

      # @param file_id [String] The id of the file to retrieve
      # @return [BddOpenai::Mapper::File, BddOpenai::ErrorResponse]
      def retrieve_file(file_id)
        uri = URI.parse("#{@openai_api_domain}/files/#{file_id}")
        response = @http_client.call_get(uri, default_headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        BddOpenai::Mapper::File.from_json(response.body)
      end
    end
  end
end
