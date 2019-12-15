# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }

  describe 'validations' do
    it { should validate_presence_of(:phrase) }
    it { should validate_presence_of(:answer) }
    it { should validate_presence_of(:card_id) }
  end

  describe 'associations' do
    it { should have_one(:typo) }
  end
end
