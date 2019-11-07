# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HandleUserAnswer, type: :service do
  let(:card) { FactoryBot.create(:card) }
  let (:answer) { FactoryBot.create(:answer, card_id: card.id) }

  describe '#translation_correct' do
    it 'has wrong answer' do
      user_answer_handler = HandleUserAnswer.new(answer, card)
      check_result = user_answer_handler.translation_correct?
      expect(check_result).to be false
    end

    it 'has correct answer' do
      answer.answer = card.translated_text
      user_answer_handler = HandleUserAnswer.new(answer, card)
      check_result = user_answer_handler.translation_correct?
      expect(check_result).to be true
    end
  end

  describe '#start' do
    it 'has review_date 3 days later when answer correct' do
      answer.answer = card.translated_text
      HandleUserAnswer.new(answer, card).start
      expect(card.review_date).to eq Date.today.next_day(3)
    end
  end
end
