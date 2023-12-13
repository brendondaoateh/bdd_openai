# frozen_string_literal: true

require_relative 'base'

module BddOpenai
  module Services
    module Files
      class Upload < Base
        # @param purpose [String] The intended purpose of the file. One of: "fine-tune", "assistants".
        # @param file_path [String] The path of the file to upload.rb
        # @return [BddOpenai::Mapper::File, BddOpenai::ErrorResponse]
        def upload_files(purpose, file_path)
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
      end
    end
  end
end
