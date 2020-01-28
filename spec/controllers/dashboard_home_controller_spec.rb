# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::HomeController, type: :controller do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }

  before { login_user(user) }

  describe 'GET #home' do
    before { get :index }

    it 'returns existing card for guess' do
      expect(assigns(:card)).to eq card
    end

    it 'returns empty answer for card without attempts' do
      expect(assigns[:answer].id).to be_nil
    end
  end
end
