# frozen_string_literal: true

require 'rails_helper'

include AnswerQualityGrades
include EFactorValues

RSpec.describe CalcEFactorService, type: :service do
  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }
  let(:interval) { create(:repetition_interval, card: card) }
  let(:quality) { BAD_RESPONSE }

  describe '.call' do
    let(:result) do
      CalcEFactorService.call(interval.EF, quality)
    end

    it 'returns DEFAULT_E_FACTOR when quality not enough' do
      expect(result).to eql DEFAULT_E_FACTOR
    end

    it 'calculates e_factor' do
      quality = PERFECT_RESPONSE
      result = CalcEFactorService.call(interval.EF, quality)
      expect(result).to be_between(MINIMUM_E_FACTOR, DEFAULT_E_FACTOR)
    end
  end
end
