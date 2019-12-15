# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TyposController, type: :controller do
  let!(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
  let(:card) { create(:card, deck: deck) }
  let(:answer) { create(:answer, card_id: card.id) }
  let!(:typo) { create(:typo, answer: answer) }

  before { login_user(user) }

  describe 'GET #show' do
    before { get :show, params: { id: typo.id } }

    it 'has success response' do
      expect(response).to have_http_status(:success)
    end

    it 'fetch right card' do
      expect(assigns(:card)).to eq(card)
    end

    it 'fetch right answer' do
      expect(assigns(:answer)).to eq(answer)
    end
  end
end
