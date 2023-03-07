module Blobs
  class BlobDecoder < ApplicationService

    def initialize(data, key)
      super()
      @data = data
      @key = key
    end

    def call
      decode_to_file
    end

    private

    def decode_to_file

      @data.gsub!('\\r', "\r")
      @data.gsub!('\\n', "\n")
      cont = Base64.decode64(@data)
      ext = accepted_extension

      file = File.new("tmp/#{@key}.#{ext}", 'wb')
      file.write(cont)

      file
    end

    def accepted_extension
      ext = @data.to_s.slice(0, 3).upcase

      ext = case ext
      when 'IVB'
        'png'
      when "/9J"
        "jpg"
      when "JVB"
        "pdf"
      when "UMF"
        "rar"
      when "U1P"
        "txt"
      else
        raise BaseException.new(cause: :unsupported_extension, message: I18n.t('exceptions.unsupported_extension'))
      end
      ext
    end

  end
end
