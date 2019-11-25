# frozen_string_literal: true

class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    @user = login_from(provider)
    if @user # authorize existing user
      redirect_to root_path, notice: I18n.t(:login_success)
    else
      begin
        # user's registration
        @user = create_from(provider)

        reset_session
        auto_login(@user)
        notice_text = I18n.t(:login_from) + provider.titleize
      rescue StandardError
        notice_text = I18n.t(:failed_login_from) + provider.titleize
      end

      redirect_to root_path, notice: notice_text
    end
  end
end
