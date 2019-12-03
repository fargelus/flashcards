# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe 'associations' do
    it { should have_many(:cards).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  describe '.reset_records_activity' do
    let(:user) { create(:user) }
    let!(:deck) do
      create(
        :deck,
        user: user,
        name: 'test',
        activity: true
      )
    end
    let(:updated_deck) { create(:deck, user: user) }

    it 'resets existing decks activity flag' do
      updated_deck.update!(activity: true)
      old_deck = Deck.find(deck.id)
      expect(old_deck.activity).to eql(false)
    end
  end
end
