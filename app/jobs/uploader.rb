
  class Uploader < ApplicationJob

    def perform(blob_id)
      blob = Blob.find blob_id
      begin
        case blob.service_type
        when 'sftp'
          Storages::Services::SftpService.upload(blob.filename)
        else
            # S3Service.upload(blob.filename)
        end
      rescue => exception
        puts exception.inspect
      else
        blob.update(uploaded: true)
      end
    end
  end
