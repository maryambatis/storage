module Storages
  module Services
    class StorageService

      def self.upload(*args, &block)
        new(*args, &block).upload
      end

      def self.download(*args, &block)
        new(*args, &block).download
      end  
    end
  end  
end