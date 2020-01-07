# Controller for user settings edit
# frozen_string_literal: true

class Dashboard::UsersController < UsersController
  before_action :fetch_user

  def edit
    @authorized_by_oauth = CheckOauthService.call(@user)
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

  def all_params
    { user: user_params, locale: params[:user_locale] }
  end

  def user_was_updated
    path = LocaleUrlCreator.call(params[:user_locale], dashboard_root_path)
    sym_locale = params[:user_locale].to_sym
    notice_text = I18n.t :account_updated, locale: sym_locale
    redirect_to path, notice: notice_text
  end
end
