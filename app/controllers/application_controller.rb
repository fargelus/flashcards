# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale, :require_login

  private

  def set_locale
    app_locales = I18n.available_locales
    locale = http_accept_language.compatible_language_from(app_locales)
    I18n.locale = locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def not_authenticated
    redirect_to login_path, alert: t(:need_login)
  end
end
