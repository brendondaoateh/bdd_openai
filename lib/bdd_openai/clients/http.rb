# frozen_string_literal: true

module BddOpenai
  module Client
    class HttpClient
      def call_get(url, headers, disable_ssl: false)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = disable_ssl ? false : true
        request = Net::HTTP::Get.new(url.path, headers)
        http.request(request)
      end
    end
  end
end
