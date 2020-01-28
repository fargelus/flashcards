# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Welcome::UserSessionsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_attrs) { attributes_for(:user) }

  context 'when logged out' do
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
            email: user.email,
            password: user_attrs[:password]
          }
        }
      end

      it 'logged in existing user' do
        post :create, params: post_user
        expect(logged_in?).to eq(true)
      end

      it 'not logged in stranger' do
        post_user[:user][:password] = '1'
        post :create, params: post_user
        expect(logged_in?).to eq(false)
      end
    end
  end
end
