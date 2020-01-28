# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::UsersController, type: :controller do
  let!(:user) { create(:user) }
  let(:new_email) { 'new@mail.com' }
  let(:generated_password) { generate :password }
  let!(:locale) { create(:locale, user: user) }

  before { login_user(user) }

  describe 'GET #edit' do
    it 'has edit action' do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    subject (:update_user) do
      {
        id: user.id,
        user: {
          email: new_email,
          password: generated_password,
          password_confirmation: generated_password
        },
        user_locale: locale.locale
      }
    end

    it 'redirects to dashboard root after update' do
      patch :update, params: update_user
      path = LocaleUrlCreator.call(locale.locale, dashboard_root_path)
      expect(response).to redirect_to path
    end

    it "updates user's email" do
      patch :update, params: update_user
      saved_email = User.find(update_user[:id]).email
      expect(saved_email).to eq(new_email)
    end

    it 'renders edit template when get bad user params' do
      update_user[:user][:password_confirmation] = generate :password
      patch :update, params: update_user
      expect(response).to render_template(:edit)
    end
  end
end
