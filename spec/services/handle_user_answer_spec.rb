# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HandleUserAnswer, type: :service do
  let(:card) { create(:card) }
  let (:answer) { create(:answer, card_id: card.id) }

  before(:each) do
    answer.answer = card.translated_text
    @check_result = HandleUserAnswer.call(answer, card)
  end

  describe '#translation_correct' do
    it 'has correct answer' do
      expect(@check_result).to be true
    end

    it 'has wrong answer' do
      answer.answer = card.translated_text.reverse
      check_result = HandleUserAnswer.call(answer, card)
      expect(check_result).to be false
    end
  end

  describe '#start' do
    it 'has review_date 3 days later when answer correct' do
      expect(card.review_date).to eq Date.today.next_day(3)
    end
  end
end
