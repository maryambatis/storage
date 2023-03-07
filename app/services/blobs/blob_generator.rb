module Blobs
  class BlobGenerator < ApplicationService
    
    def initialize(client, params)
      @client = client
      @params = params
    end

    def call
      blob = Blob.find_by(key: key)
      return blob if blob.present?

      file = BlobDecoder.call(@params[:data], key)

      blob = Blob.create(
        key: key, #:unique 
        filename: file.path.split("/").last,
        content_type: Rack::Mime::MIME_TYPES['.' + file.path.split('.').last],
        byte_size: file.size,
        client_id: @client.id
      )
    
      Storages::StorageUploader.call(blob)

      blob
    end

    private

    def key
      @key ||= @params[:id]
    end

  end
end