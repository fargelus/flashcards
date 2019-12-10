# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttemptHour, type: :model do
  let!(:attempt_hour) { create(:attempt_hour) }

  describe 'validations' do
    it { should validate_presence_of(:attempt) }
    it { should validate_presence_of(:next_attempt_in_hours) }
    it { should validate_numericality_of(:attempt).only_integer }
    it { should validate_numericality_of(:next_attempt_in_hours).only_integer }
    it { should validate_numericality_of(:attempt).is_less_than(6) }
  end

  describe '.get_attempt_hours' do
    it 'returns next_attempt_in_hours field' do
      hours = AttemptHour.get_attempt_hours(attempt_hour.attempt)
      expect(hours).to eql attempt_hour.next_attempt_in_hours
    end
  end
end
