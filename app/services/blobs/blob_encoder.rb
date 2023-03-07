module Blobs
  class BlobEncoder < ApplicationService

    def initialize(filename)
      super()
      @local_path = Rails.application.secrets.dig(:sftp, :local_path)
      @filename = filename
    end

    def call
      file_to_encode
    end
    private

    def file_to_encode
      file = File.open("#{@local_path}#{@filename}")
      file_data = file.read
      
      raise BaseException.new(cause: :unsupported_extension, message: I18n.t('exceptions.unsupported_extension')) if file_data.empty?
      
      Base64.encode64(file_data).gsub(/\n/,"")
    end
  end
end