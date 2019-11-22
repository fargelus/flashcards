# frozen_string_literal: true

class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:crypted_password])
      redirect_to user_path, notice: I18n.t(:login_success)
    else
      flash.now[:alert] = I18n.t(:login_failed)
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: I18n.t(:logout)
  end
end
