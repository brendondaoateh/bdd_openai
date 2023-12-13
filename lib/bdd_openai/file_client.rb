# frozen_string_literal: true

require_relative 'services/files/delete'
require_relative 'services/files/list'
require_relative 'services/files/retrieve'
require_relative 'services/files/upload'

module BddOpenai
  # Client for OpenAI Files API
  # Ref: https://platform.openai.com/docs/api-reference/files
  class FileClient
    # @param api_key [String] The key of the OpenAI API
    attr_accessor :api_key

    def initialize(api_key = '')
      @api_key = api_key
    end

    # @return [Array<BddOpenai::Mapper::File>, BddOpenai::ErrorResponse]
    def list_files
      BddOpenai::Services::Files::List.new(@api_key).list_files
    end

    # @param purpose [String] The intended purpose of the file. One of: "fine-tune", "assistants".
    # @param file_path [String] The path of the file to upload.rb
    # @return [BddOpenai::Mapper::File, BddOpenai::ErrorResponse]
    def upload_file(purpose, file_path)
      BddOpenai::Services::Files::Upload.new(@api_key).upload_files(purpose, file_path)
    end

    # @param file_id [String] The id of the file to delete
    # @return [true, BddOpenai::ErrorResponse]
    def delete_file(file_id)
      BddOpenai::Services::Files::Delete.new(@api_key).delete_file(file_id)
    end

    # @param file_id [String] The id of the file to retrieve
    # @return [BddOpenai::Mapper::File, BddOpenai::ErrorResponse]
    def retrieve_file(file_id)
      BddOpenai::Services::Files::Retrieve.new(@api_key).retrieve_file(file_id)
    end
  end
end
