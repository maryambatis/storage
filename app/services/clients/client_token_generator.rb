module Clients
  class ClientTokenGenerator < ApplicationService
    include AuthenticationHelper

    def initialize(params)
      @params = params
    end

    def call

      client
    end

    def client
      client = Client.find_by(id: @params[:client_id])
      raise UnauthorizedExpception if client.blank? || client.secret != @params[:client_secret]
      
      exp = 1.hours.from_now.to_i
      client.experied_at = exp

      client.token = encode({client_id: client.id, }, exp = exp)
      client.save
      
      client
    end
  end
end