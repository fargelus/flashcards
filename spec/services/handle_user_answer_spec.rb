# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HandleUserAnswer, type: :service do
  let(:card) { FactoryBot.create(:card) }
  let (:answer) { FactoryBot.create(:answer, card_id: card.id) }

  describe '#translation_correct' do
    it 'answer is correct translation' do
      user_answer_handler = HandleUserAnswer.new(answer, card)
      check_result = user_answer_handler.translation_correct?
      expect(check_result).to be false
    end
  end
end
