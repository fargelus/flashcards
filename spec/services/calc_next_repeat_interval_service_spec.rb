# frozen_string_literal: true

require 'rails_helper'

include AnswerQualityGrades
include EFactorValues

RSpec.describe CalcNextRepeatIntervalService, type: :service do
  let!(:card) { create(:card) }
  let!(:answer) { create(:answer, card_id: card.id) }
  let(:intervals) { create_list(:repetition_interval, 3, card: card) }
  let(:interval) { intervals.first }

  describe '.call' do
    it 'returns calculated interval' do
      result = CalcNextRepeatIntervalService.call(card.id, interval.EF)
      expect(result).to be_a(Integer)
    end
  end
end
