# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale, :require_login

  private

  def default_url_options
    { locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
  end

  def set_locale
    I18n.locale = new_visiter? ? browser_locale : select_locale
  end

  def new_visiter?
    session[:locale].nil? && current_user.blank?
  end

  def browser_locale
    app_locales = I18n.available_locales
    locale = http_accept_language.compatible_language_from(app_locales)
    session[:locale] = locale
  end

  def select_locale
    current_user&.locale&.locale || params[:locale] || I18n.default_locale
  end

  def not_authenticated
    redirect_to login_path, alert: t(:need_login)
  end
end
