# Controller for card's users
# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :fetch_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def edit
    @authorized_by_oauth = CheckOauthService.call(@user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      SetUserLocaleService.call(@user)
      auto_login(@user)
      redirect_to root_path, notice: I18n.t(:reg_success)
    else
      render 'new'
    end
  end

  def update
    if UpdateUserService.call(@user, all_params)
      user_was_updated
    else
      render 'edit'
    end
  end

  private

  def fetch_user
    @user = User.find(params[:id])
  end

  def user_params
    if params[:user]
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :authentications_attributes,
        :avatar
      )
    end
  end

  def all_params
    { user: user_params, locale: params[:user_locale] }
  end

  def user_was_updated
    path = LocaleUrlCreator.call(params[:user_locale], root_path)
    sym_locale = params[:user_locale].to_sym
    notice_text = I18n.t :account_updated, locale: sym_locale
    redirect_to path, notice: notice_text
  end
end
