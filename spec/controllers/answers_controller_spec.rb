# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let(:card) { create(:card, user_id: user.id) }
  let(:test_answer) { create(:answer, card_id: card.id) }

  subject(:post_answer) do
    {
      card_id: card.id,
      answer: {
        phrase: test_answer.phrase,
        answer: test_answer.answer
      }
    }
  end

  describe 'POST #create' do
    before(:each) { login_user(user) }

    it 'redirects back to root after create' do
      post :create, params: post_answer
      expect(response).to redirect_to(root_path)
    end

    it 'creates one more answer after post' do
      expect { post :create, params: post_answer }.to change { Answer.count }.by(2)
    end
  end
end
