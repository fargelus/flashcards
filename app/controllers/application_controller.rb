# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :browser_locale, if: :first_entrance?
  before_action :set_locale, :require_login

  private

  def browser_locale
    locale = BrowserLocaleService.call(I18n.available_locales)
    session[:locale] = locale
    redirect_to url_for(locale: locale)
  end

  def first_entrance?
    current_user.blank? && session[:locale].nil?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
  end

  def not_authenticated
    redirect_to login_path, alert: t(:need_login)
  end
end
