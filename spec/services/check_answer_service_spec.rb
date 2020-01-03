# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckAnswerService, type: :service do
  include CardsHelper

  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }

  before do
    answer.answer = card.translated_text
    @check_result = CheckAnswerService.call(answer, card)
  end

  describe '#translation_correct' do
    it 'has correct answer' do
      expect(@check_result).to be true
    end

    it 'has wrong answer' do
      answer.answer = card.translated_text.reverse
      check_result = CheckAnswerService.call(answer, card)
      expect(check_result).to be false
    end
  end
end
