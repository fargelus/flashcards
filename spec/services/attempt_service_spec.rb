# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttemptService, type: :service do
  let(:attempt) { create(:attempt) }
  let(:attempt_service) { AttemptService.new(attempt) }

  describe '#reset_attempts_count' do
    it 'reset_all_attempts_count' do
      attempt_service.reset_attempts_count
      expect(attempt.success).to eql attempt.failure
    end
  end
end
