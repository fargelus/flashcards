# General methods for UsersController descendants
# frozen_string_literal: true

class UsersController < ApplicationController
  protected

  def user_params
    if params[:user]
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :avatar,
        :authentications_attributes
      )
    end
  end
end
