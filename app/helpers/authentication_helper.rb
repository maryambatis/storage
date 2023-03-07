module AuthenticationHelper

  SECRET_KEY = Rails.application.secrets.dig(:secret_key_base)

  def decode(token)
    JWT.decode(token, SECRET_KEY)[0]
  end

  def encode(payload, exp = 1.years.from_now.to_i)
    payload[:exp] = exp
    JWT.encode(payload, SECRET_KEY)
  end

end