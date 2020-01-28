# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Welcome::UsersController, type: :controller do
  let!(:user) { create(:user) }
  let(:new_email) { 'new@mail.com' }
  let(:generated_password) { generate :password }

  describe 'GET #new' do
    it 'response 200' do
      get :new
      expect(response.status).to eq(200)
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

    it 'redirects to dashboard root after create' do
      post :create, params: post_user
      expect(response).to redirect_to dashboard_root_path
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
end
