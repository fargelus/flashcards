# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attempt, type: :model do
  let!(:attempt) { create(:attempt) }

  describe 'validations' do
    it { should validate_presence_of(:card_id) }
    it { should validate_numericality_of(:success).only_integer }
    it { should validate_numericality_of(:failure).only_integer }
    it { should validate_uniqueness_of(:card_id) }
  end

  describe 'associations' do
    it { should belong_to(:card) }
  end
end
