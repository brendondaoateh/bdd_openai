# frozen_string_literal: true

module BddOpenai
  # Namespace for all external clients
  module Client
    # An HTTP client
    class HttpClient
      # @param uri [URI::Generic]
      # @param headers [Hash]
      # @param disable_ssl [Boolean]
      # @return [Net::HTTPResponse]
      def call_get(uri, headers, disable_ssl: false)
        http = Net::HTTP.new(uri.host || '', uri.port)
        http.use_ssl = disable_ssl ? false : true
        request = Net::HTTP::Get.new(uri.path || '', headers)
        http.request(request)
      end

      # @param uri [URI::Generic]
      # @param req_body [String] Request body in the form of JSON string.
      # @param headers [Hash]
      # @param disable_ssl [Boolean]
      # @return [Net::HTTPResponse]
      def call_post(uri, req_body, headers, disable_ssl: false)
        http = Net::HTTP.new(uri.host || '', uri.port)
        http.use_ssl = disable_ssl ? false : true
        request = Net::HTTP::Post.new(uri.path || '', headers)
        request.body = req_body unless req_body.nil?
        http.request(request)
      end

      # @param fields [Hash] The fields to be sent in the request body
      # @param file_fields [Hash] The file fields to be sent in the request body, with value as the file path.
      # @return [String, String (frozen)] The request body and the boundary string
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

      # @param uri [URI::Generic]
      # @param headers [Hash]
      # @param disable_ssl [Boolean]
      # @return [Net::HTTPResponse]
      def call_delete(uri, headers, disable_ssl: false)
        http = Net::HTTP.new(uri.host || '', uri.port)
        http.use_ssl = disable_ssl ? false : true
        request = Net::HTTP::Delete.new(uri.path || '', headers)
        http.request(request)
      end
    end
  end
end
