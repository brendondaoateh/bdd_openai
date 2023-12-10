# frozen_string_literal: true

module BddOpenai
  # Module for OpenAI Files API
  # Ref: https://platform.openai.com/docs/api-reference/files
  module Files
    # Client for OpenAI Files API
    class Client
      def initialize(**args)
        @api_domain = 'https://api.openai.com/v1'

        args.each do |k, v|
          instance_variable_set("@#{k}", v) unless v.nil?
        end
      end

      def list_files
        URI.parse("#{@api_domain}/files")
        response = @http_client.call_get(url, default_headers)
        return BddOpenai::ErrorResponse.from_json(response.body) unless response.code == '200'

        JSON.parse(response.body)['data'].map do |file|
          BddOpenai::Files::File.from_json(file.to_json)
        end
      end
    end
  end
end
