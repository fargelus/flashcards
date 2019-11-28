# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :cards?

  private

  def cards?
    current_user && current_user.cards.count.positive?
  end

  def not_authenticated
    redirect_to login_path, alert: t(:need_login)
  end
end
