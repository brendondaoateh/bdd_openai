# frozen_string_literal: true

module BddOpenai
  # Module for OpenAI Files API
  # Ref: https://platform.openai.com/docs/api-reference/files
  module Files
    # The File object
    # Ref: https://platform.openai.com/docs/api-reference/files/object
    class File
      # @return [String] The file identifier, which can be referenced in the API endpoints.
      attr_accessor :id
      # @return [Integer] The size of the file, in bytes.
      attr_accessor :bytes
      # @return [Integer] The Unix timestamp (in seconds) for when the file was created.
      attr_accessor :created_at
      # @return [String] The name of the file.
      attr_accessor :filename
      # @return [String] The object type, which is always "file".
      attr_accessor :object
      # @return [String] The intended purpose of the file. Supported values are \
      #   "fine-tune", "fine-tune-results", "assistants", and "assistants_output".
      attr_accessor :purpose

      def self.from_json(json_string)
        data = JSON.parse(json_string)
        new(
          id: data['id'],
          bytes: data['bytes'],
          created_at: data['created_at'],
          filename: data['filename'],
          object: data['object'],
          purpose: data['purpose']
        )
      end

      def initialize(**args)
        args.each do |k, v|
          instance_variable_set("@#{k}", v) unless v.nil?
        end
      end
    end
  end
end
