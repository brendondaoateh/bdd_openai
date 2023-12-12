# frozen_string_literal: true

require_relative 'base'

module BddOpenai
  module Services
    module Files
      class List < Base
        # @return [Array<BddOpenai::Mapper::File>, BddOpenai::ErrorResponse]
        def list_files
          uri = URI.parse("#{@openai_api_domain}/files")
          response = @http_client.call_get(uri, default_headers)
          return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

          JSON.parse(response.body)['data'].map do |file|
            BddOpenai::Mapper::File.from_json(file.to_json)
          end
        end
      end
    end
  end
end
