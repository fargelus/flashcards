# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:card) { create(:card) }
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

  describe '#create' do
    it 'redirected back to root after create' do
      post :create, params: post_answer
      expect(response).to redirect_to(root_path)
    end

    it 'creates one more answer after post' do
      expect { post :create, params: post_answer }.to change { Answer.count }.by(2)
    end
  end
end
