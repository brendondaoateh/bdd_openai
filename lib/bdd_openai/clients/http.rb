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

      def call_post(uri, req_body, headers, disable_ssl: false)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = disable_ssl ? false : true
        request = Net::HTTP::Post.new(uri.path, headers)
        request.body = req_body unless req_body.nil?
        http.request(request)
      end

      def create_multipart_body(fields, file_fields)
        boundary = "----#{SecureRandom.hex(16)}"
        body = +''
        fields.each do |name, value|
          body << "--#{boundary}\r\n"
          body << "Content-Disposition: form-data; name=\"#{name}\"\r\n\r\n"
          body << "#{value}\r\n"
        end
        file_fields.each do |name, file_path|
          body << "--#{boundary}\r\n"
          body << "Content-Disposition: form-data; name=\"#{name}\"; filename=\"#{File.basename(file_path)}\"\r\n"
          body << "Content-Type: application/octet-stream\r\n\r\n"
          body << "#{File.read(file_path)}\r\n"
        end
        body << "--#{boundary}--\r\n"
        [body, boundary]
      end
    end
  end
end
