# Controller for oauth signs
# frozen_string_literal: true

module Welcome
  class OauthsController < WelcomeController
    def oauth
      login_at(params[:provider])
    end

    def callback
      provider = params[:provider]
      @user = login_from(provider)
      if @user # authorize existing user
        redirect_to dashboard_root_path, notice: I18n.t(:login_success)
      else
        register_user_from_provider provider
      end
    end

    private

    def register_user_from_provider(provider)
      redirect_path = root_path
      begin
        # user's registration
        @user = create_from(provider)

        reset_session
        auto_login(@user)
        notice_text = I18n.t(:login_from) + provider.titleize
        redirect_path = dashboard_root_path
      rescue StandardError
        notice_text = I18n.t(:failed_login_from) + provider.titleize
      end

      redirect_to redirect_path, notice: notice_text
    end
  end
end
