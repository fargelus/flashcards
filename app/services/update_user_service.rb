# frozen_string_literal: true

class UpdateUserService < Callable
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    if CheckOauthService.call(@user)
      update_side_attributes
    else
      update_locale
      @user.update!(@params[:user])
    end
  end

  private

  def update_side_attributes
    avatar = @params[:user] && @params[:user][:avatar]
    @user.update_attribute!(:avatar, avatar) if avatar.present?
    update_locale
  end

  def update_locale
    SetUserLocaleService.call(@user, locale: @params[:locale])
  end
end
