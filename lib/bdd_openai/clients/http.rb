# frozen_string_literal: true

module BddOpenai
  module Client
    class HttpClient
      def call_get(uri, headers, disable_ssl: false)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = disable_ssl ? false : true
        request = Net::HTTP::Get.new(uri.path, headers)
        http.request(request)
      end
    end
  end
end
