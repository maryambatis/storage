module Storages
  class StorageDownloader < ApplicationService

    def initialize(blob)
      super()
      @blob = blob
    end

    def call
      case @blob.service_type
      when 'sftp' 
        begin
          case @blob.service_type
          when 'sftp'
            Services::SftpService.download(@blob.filename)
          else
              # S3Service.upload(blob.filename)
          end
        rescue => exception
          puts exception.inspect
          raise  BaseException.new(cause: :sftp_service_unavailable, message: I18n.t('exceptions.sftp_service_unavailable')) 
        else
          encoded = Blobs::BlobEncoder.call(@blob.filename)
        end
      else
        # S3Downloader.perform(blob)
      end
      
      encoded
    end
  end
end