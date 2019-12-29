# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, activity: true, user: user) }
  let!(:card) { create(:card, deck: deck) }

  describe '.cards' do
    it 'has cards' do
      expect(cards?(user)).to be true
    end

    it 'has no cards' do
      card.destroy
      expect(cards?(user)).to be false
    end
  end

  describe '.active_deck' do
    it 'returns user current active deck' do
      expect(active_deck(user)).to eq deck
    end
  end
end
