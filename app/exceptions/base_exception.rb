# frozen_string_literal: true

class BaseException < StandardError
  attr_accessor :cause, :message, :status

  def initialize(cause: :unprocessable_entity, message: I18n.t('exceptions.unprocessable_entity'), status: :unprocessable_entity)
    @message = message
    @cause = cause
    @status = status
  end
end
