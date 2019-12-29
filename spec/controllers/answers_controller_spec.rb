# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create :user }
  let(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }
  let(:test_answer) { create(:answer, card_id: card.id) }
  let!(:attempt) { create(:attempt, card: card) }

  subject(:post_answer) do
    {
      card_id: card.id,
      answer: {
        phrase: test_answer.phrase,
        answer: test_answer.answer
      }
    }
  end

  before { login_user(user) }

  describe 'POST #create' do
    it 'redirects back to root after create' do
      post :create, params: post_answer
      expect(response).to redirect_to(root_path)
    end

    it 'creates one more answer after post' do
      expect { post :create, params: post_answer }.to change { Answer.count }.by(2)
    end
  end

  describe 'PATCH #update' do
    it 'redirects to root_path after update' do
      patch :update, params: { card_id: card.id, id: test_answer.id }
      expect(response).to redirect_to root_path
    end
  end
end
