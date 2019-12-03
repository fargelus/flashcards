# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DecksHelper, type: :helper do
  describe '#deck_name' do
    let(:deck) { build(:deck) }

    it 'returns capitalized string' do
      expected = deck_name(deck)
      actual = deck.name
      expect(expected.first).to eq actual.first.upcase
    end
  end
end
