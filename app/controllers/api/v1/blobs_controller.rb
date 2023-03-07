module Api
  module V1
    class BlobsController < ApplicationController

      def create
        raise BaseException.new if params[:data].blank? || params[:id].blank?

        blob = Blobs::BlobGenerator.call(current_client, params)
        encoded_data = params[:data][0,50]
        
        render json: BlobsPrinter.render_as_json(blob, data: encoded_data), status: :ok
      rescue BaseException => e
        render(
          json: { errors: [{ cause: e.cause, message: e.message }] },
          status: e.status
        )
      end

      def show
        blob = Blob.find_by(key:  params[:id])
        raise BaseException.new if blob.blank? || blob.client_id != current_client.id

        encoded_data = Blobs::BlobFetcher.call(blob)

        render json: BlobsPrinter.render_as_json(blob, data: encoded_data), status: :ok
      rescue BaseException => e
        render(
          json: { errors: [{ cause: e.cause, message: e.message }] },
          status: e.status
        )
      end

      private

      def post_params
        params.permit(:id, :data, :size)
      end
    end
  end
end














# def create
#   blob = Blobs::BlobGenerator.call(current_client)

#   render json: BlobsPrinter.render_as_json(blob), status: :ok
#   render(
#     json: { errors: [{ cause: e.cause, message: e.message }] },
#     status: e.status
#   )
# end

# def show
#   blob = Blobs::BlobsFetcher.call(current_client, params[:id])

#   render json: BlobsPrinter.render_as_json(blob), status: :ok
# rescue Exceptions::BaseException => e
#   render(
#     json: { errors: [{ cause: e.cause, message: e.message }] },
#     status: e.status
#   )
# end
