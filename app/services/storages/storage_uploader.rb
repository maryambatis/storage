module Storages
  class StorageUploader < ApplicationService

    def initialize(blob)
      super()
      @blob = blob
    end

    def call
      service = ServiceSelector.call(@blob)

      case service
      when 'sftp'
        Uploader.perform_now(@blob.id)
      else
        # S3Uploader.perform(blob)
      end
    end


    
  end
end