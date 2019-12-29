# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let(:new_email) { 'new@mail.com' }
  let(:generated_password) { generate :password }
  let!(:locale) { create(:locale, user: user) }

  context 'when logged out' do
    describe 'GET #new' do
      it 'response 200' do
        get :new
        expect(response.status).to eq(200)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login_path' do
        get :edit, params: { id: User.last.id }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  context 'when logged in' do
    before(:each) { login_user(user) }

    describe 'GET #edit' do
      it 'has edit action' do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST #create' do
      subject (:post_user) do
        {
          user: {
            email: new_email,
            password: generated_password,
            password_confirmation: generated_password
          }
        }
      end

      it 'redirects to root after create' do
        post :create, params: post_user
        expect(response).to redirect_to root_path
      end

      it 'immediately login new user' do
        logout_user
        post :create, params: post_user
        expect(logged_in?).to eq(true)
      end

      it 'renders new template when new user bad' do
        post_user[:user][:email] = ''
        post :create, params: post_user
        expect(response).to render_template(:new)
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

      it 'redirects to root after update' do
        patch :update, params: update_user
        path = LocaleUrlCreator.call(locale.locale, root_path)
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
end
