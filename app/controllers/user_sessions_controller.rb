# Controller for user session
# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = login(*session_params)
    if @user
      redirect_back_or_to root_path, notice: I18n.t(:login_success)
    else
      flash.now[:alert] = I18n.t(:login_failed)
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private

  def session_params
    choose_param = ->(param) { params[param] || params[:user][param] }
    result_params = %i[email password].map { |param| choose_param.call(param) }
    result_params << params[:remember_me]
  end
end
