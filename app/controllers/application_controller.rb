class ApplicationController < ActionController::Base
  include AuthenticationHelper

  before_action :authenticate!
  skip_before_action :verify_authenticity_token

  def authenticate!
    return head :unauthorized if request.headers['Authorization'].blank?

    header_token = request.headers['Authorization']&.split(' ')&.last

    decoded = decode(header_token) if header_token

    return head :unauthorized if decoded['client_id'].blank?

    @current_client = Client.find(decoded['client_id'])
  rescue JWT::ExpiredSignature
    return render(
      json: { errors: [{ cause: :token_expired, message: I18n.t('api.v1.clients.errors.token_expired') }] },
      status: :unauthorized
    )
  rescue JWT::DecodeError
    return render(
      json: { errors: [{ cause: :unauthorized, message: I18n.t('api.v1.clients.errors.unauthorized') }] },
      status: :unauthorized
    )
  end

  def current_client
    @current_client
  end
end
