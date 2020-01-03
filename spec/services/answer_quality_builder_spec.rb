# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerQualityBuilder, type: :service do
  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }

  describe '.call' do
    include AnswerQualityGrades
    include ResponseTimeMeasures

    let(:response_time) { ResponseTimeMeasures::FAST_RESPONSE_TIME }
    let(:result) do
      AnswerQualityBuilder.call(answer, response_time)
    end

    it 'returns bad response when answer wrong' do
      answer.wrong = true
      answer.save!
      expect(result).to eq AnswerQualityGrades::BAD_RESPONSE
    end

    it 'returns some typo response if answer with typo' do
      answer.typo = true
      answer.save!
      expect(result).to be_between(
        AnswerQualityGrades::SLOW_TYPO_RESPONSE,
        AnswerQualityGrades::FAST_TYPO_RESPONSE
      )
    end

    it 'returns correct response' do
      expect(result).to eql AnswerQualityGrades::PERFECT_RESPONSE
    end

    it 'returns hesitation response' do
      response_time = ResponseTimeMeasures::DELAY_RESPONSE_TIME
      result = AnswerQualityBuilder.call(answer, response_time)
      expect(result).to eql AnswerQualityGrades::HESITATION_RESPONSE
    end

    it 'returns difficult response' do
      response_time = 10_000
      result = AnswerQualityBuilder.call(answer, response_time)
      expect(result).to eql AnswerQualityGrades::DIFFICULT_RESPONSE
    end
  end
end
