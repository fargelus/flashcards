# Controller for new app users
# frozen_string_literal: true

module Welcome
  class UsersController < ApplicationController
    include UserMethods

    skip_before_action :require_login

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        SetUserLocaleService.call(@user)
        auto_login(@user)
        redirect_to dashboard_root_path, notice: I18n.t(:reg_success)
      else
        render 'new'
      end
    end
  end
end
