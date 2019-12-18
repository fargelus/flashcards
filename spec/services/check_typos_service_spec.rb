# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckTyposService, type: :service do
  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }
  let(:random_phrase) { generate :phrase }

  describe '#call' do
    context 'when returns false' do
      it 'has correct answer' do
        answer.answer = card.translated_text
        result = CheckTyposService.call(answer, card)
        expect(result).to be_falsey
      end

      it 'has many edits' do
        answer.answer = random_phrase
        result = CheckTyposService.call(answer, card)
        expect(result).to be_falsey
      end
    end

    context 'when returns true' do
      it 'has enough edits' do
        answer.answer = card.translated_text[1..]
        result = CheckTyposService.call(answer, card)
        expect(result).to be true
      end
    end
  end
end
