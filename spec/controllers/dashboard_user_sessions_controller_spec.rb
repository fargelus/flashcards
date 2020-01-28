# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::UserSessionsController, type: :controller do
  let!(:user) { create(:user) }

  describe 'DELETE #destroy' do
    it 'redirects to login_path' do
      delete :destroy
      expect(response).to redirect_to login_path
    end
  end

  context 'when logged in' do
    before { login_user(user) }

    describe 'DELETE #destroy' do
      it 'redirects to root_path' do
        delete :destroy
        expect(response).to redirect_to root_path
      end

      it 'logout when destroy session' do
        delete :destroy
        expect(logged_in?).to eq false
      end
    end
  end
end
