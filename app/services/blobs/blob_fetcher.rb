module Blobs
  class BlobFetcher < ApplicationService
    
    def initialize(blob)
      @blob = blob
    end

    def call
      Storages:: StorageDownloader.call(@blob)
    end
  end
end