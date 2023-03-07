module Api
  module V1

    class ClientsController < ApplicationController
      skip_before_action :authenticate!, only: %i[access_token]
    
      def access_token
        client = Clients::ClientTokenGenerator.call(params)
    
        render json: ClientsPrinter.render_as_json(client), status: :ok
      rescue BaseException => e
        render(
          json: { errors: [{ cause: e.cause, message: e.message }] },
          status: e.status
        )
      end

      private
      
      def post_params
        params.permit(:token, :experied_at)
      end
    end
    
  end
  
end