# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalcEFactorService, type: :service do
  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }
  let(:interval) { create(:repetition_interval, card: card) }

  describe '.call' do
    include AnswerQualityGrades
    include EFactorValues

    let(:quality) { AnswerQualityGrades::BAD_RESPONSE }
    let(:result) do
      CalcEFactorService.call(interval.e_factor, quality)
    end

    it 'returns DEFAULT_E_FACTOR when quality not enough' do
      expect(result).to eql EFactorValues::DEFAULT_E_FACTOR
    end
  end

  describe '.calc_e_factor' do
    it 'returns default e_factor with response perfect' do
      quality = AnswerQualityGrades::PERFECT_RESPONSE
      result = CalcEFactorService.call(interval.e_factor, quality)
      expect(result).to be EFactorValues::DEFAULT_E_FACTOR
    end

    it 'returns calculated e_factor value with difficult response' do
      quality = AnswerQualityGrades::DIFFICULT_RESPONSE
      result = CalcEFactorService.call(interval.e_factor, quality)
      expect(result).to be_between(
        EFactorValues::MINIMUM_E_FACTOR,
        EFactorValues::DEFAULT_E_FACTOR
      )
    end
  end
end
