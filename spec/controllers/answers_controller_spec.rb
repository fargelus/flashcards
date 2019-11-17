# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:card) { create(:card) }
  let(:test_answer) { create(:answer, card_id: card.id) }

  subject(:post_answer) {
    {
      card_id: card.id,
      answer: {
        phrase: test_answer.phrase,
        answer: test_answer.answer
      }
    }
  }

  describe '#create' do
    it 'redirected back to root after create' do
      post :create, params: post_answer
      expect(response).to redirect_to(root_path)
    end

    it 'creates one more answer after post' do
      old_count = Answer.count
      post :create, params: post_answer
      new_count = Answer.count
      expect(new_count).to be > old_count
    end
  end
end
