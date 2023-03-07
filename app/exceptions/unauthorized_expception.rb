# frozen_string_literal: true

class UnauthorizedExpception < BaseException

  def initialize
    super(cause: :unauthorized, message: I18n.t('exceptions.unauthorized'), status: :unauthorized)
  end

end
