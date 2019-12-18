# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SetAnswerTypoService, type: :service do
  let!(:card) { create(:card) }
  let!(:answer) { create(:answer, card_id: card.id) }

  describe '.call' do
    it "set value of answer's typo" do
      SetAnswerTypoService.call(answer, true)
      expect(answer.typo).to be true
    end
  end
end
