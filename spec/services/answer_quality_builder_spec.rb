# frozen_string_literal: true

require 'rails_helper'

include AnswerQualityGrades
include ResponseTimeMeasures

RSpec.describe AnswerQualityBuilder, type: :service do
  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }
  let(:response_time) { FAST_RESPONSE_TIME }

  describe '.call' do
    let(:result) do
      AnswerQualityBuilder.call(answer, response_time)
    end

    it 'returns bad response when answer wrong' do
      answer.wrong = true
      answer.save!
      expect(result).to eq BAD_RESPONSE
    end

    it 'returns some typo response if answer with typo' do
      answer.typo = true
      answer.save!
      expect(result).to be_between(SLOW_TYPO_RESPONSE, FAST_TYPO_RESPONSE)
    end

    it 'returns correct response' do
      expect(result).to eql PERFECT_RESPONSE
    end

    it 'returns hesitation response' do
      response_time = DELAY_RESPONSE_TIME
      result = AnswerQualityBuilder.call(answer, response_time)
      expect(result).to eql HESITATION_RESPONSE
    end

    it 'returns difficult response' do
      response_time = 10_000
      result = AnswerQualityBuilder.call(answer, response_time)
      expect(result).to eql DIFFICULT_RESPONSE
    end
  end
end
