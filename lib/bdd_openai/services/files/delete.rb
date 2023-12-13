# frozen_string_literal: true

require_relative 'base'

module BddOpenai
  module Services
    module Files
      class Delete < Base
        # @param file_id [String] The id of the file to delete
        # @return [true, BddOpenai::ErrorResponse]
        def delete_file(file_id)
          uri = URI.parse("#{@openai_api_domain}/files/#{file_id}")
          response = @http_client.call_delete(uri, default_headers)
          return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

          true
        end
      end
    end
  end
end
