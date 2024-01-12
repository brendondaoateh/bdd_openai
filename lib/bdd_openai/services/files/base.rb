# frozen_string_literal: true

module BddOpenai
  module Services
    module Files
      class Base
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
      end
    end
  end
end
