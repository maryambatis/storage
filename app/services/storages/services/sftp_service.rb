require 'net/sftp'
require 'uri'

module Storages
  module Services
    class SftpService < StorageService

      def initialize(filename)
        @host = Rails.application.secrets.dig(:sftp, :host)
        @user = Rails.application.secrets.dig(:sftp, :user)
        @password = Rails.application.secrets.dig(:sftp, :password)
        @port = Rails.application.secrets.dig(:sftp, :port)
        @remote_path = Rails.application.secrets.dig(:sftp, :remote_path)
        @local_path = Rails.application.secrets.dig(:sftp, :local_path)
        @filename = filename
      end

      def upload
        connect
        @sftp_client.upload!("#{@local_path}#{@filename}", "#{@remote_path}#{@filename}")
        puts "Uploaded #{@remote_path}#{@filename}"
        disconnect
      end

      def download
        connect
        @sftp_client.download!("#{@remote_path}#{@filename}", "#{@local_path}#{@filename}")
        puts "Downloaded #{@local_path}#{@filename}"
        disconnect
      end

      private

      def connect
        sftp_client.connect!

      rescue Net::SSH::ConnectionTimeout
        puts "Failed to connect to #{@host}"
      end

      def disconnect
        sftp_client.close_channel
        ssh_session.close
      end
      
      def sftp_client
        @sftp_client ||= Net::SFTP::Session.new(ssh_session)
      end
    
      def ssh_session
        @ssh_session ||= Net::SSH.start(@host, @user, password: @password, port: @port)
      end
    end
  end  
end