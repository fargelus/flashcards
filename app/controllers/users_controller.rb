# Controller for card's users
# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :fetch_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: I18n.t(:reg_success)
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: I18n.t(:account_updated)
    else
      render 'edit'
    end
  end

  private

  def fetch_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
