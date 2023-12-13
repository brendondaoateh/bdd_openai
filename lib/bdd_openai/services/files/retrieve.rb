# frozen_string_literal: true

require_relative 'base'

module BddOpenai
  module Services
    module Files
      class Retrieve < Base
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
end
