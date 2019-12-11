# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttemptService, type: :service do
  let!(:card) { create(:card) }
  let!(:attempt) { create(:attempt, card: card) }

  describe '#call' do
    it 'resets all attempts count' do
      attempt_service = AttemptService.call(card.id, success: 0, failure: 0)
      expect(attempt.success).to eql attempt.failure
    end
  end
end
