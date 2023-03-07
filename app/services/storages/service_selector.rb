module Storages
  class ServiceSelector < ApplicationService

    def initialize(blob)
      super()
      @blob = blob
    end

    def call
      service = select
      @blob.update(service_type: service)

      Blob.service_types.key service
    end

    def select
      return Blob.service_types[:sftp] if @blob.byte_size > 1000

      Blob.service_types[:s3]
    end

  end
end