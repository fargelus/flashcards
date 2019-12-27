# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :browser_locale, if: :first_entrance?
  before_action :set_locale, :require_login

  private

  def first_entrance?
    current_user.blank? && session[:locale].nil?
  end

  def browser_locale
    app_locales = I18n.available_locales
    locale = http_accept_language.compatible_language_from(app_locales)
    session[:locale] = locale
    redirect_to url_for(locale: locale) if need_locale_redirect?(locale)
  end

  def need_locale_redirect?(locale)
    locale && params[:locale] != locale
  end

  def default_url_options
    { locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
  end

  def set_locale
    I18n.locale = select_locale
  end

  def select_locale
    current_user&.locale&.locale || params[:locale] || I18n.default_locale
  end

  def not_authenticated
    redirect_to login_path, alert: t(:need_login)
  end
end
