# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]
    pwd = params[:user][:password]

    @user = login(email, pwd)
    if @user
      redirect_to root_path, notice: I18n.t(:login_success)
    else
      flash.now[:alert] = I18n.t(:login_failed)
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
