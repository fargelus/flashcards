# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAnswerService, type: :service do
  include CardsHelper

  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }
  let!(:attempt) { create(:attempt, card: card) }
  let!(:attempt_hour) { create(:attempt_hour) }

  before do
    answer.answer = card.translated_text
    @check_result = UserAnswerService.call(answer, card)
  end

  describe '#translation_correct' do
    it 'has correct answer' do
      expect(@check_result).to be true
    end

    it 'has wrong answer' do
      answer.answer = card.translated_text.reverse
      check_result = UserAnswerService.call(answer, card)
      expect(check_result).to be false
    end
  end

  describe '#start' do
    context 'when answer correct' do
      it 'has review_date some hours later' do
        future_check = attempt_hour.next_attempt_in_hours
        actual = format_date(card.review_date)
        got = format_date(hours_after(future_check))
        expect(actual).to eq got
      end
    end
  end
end
