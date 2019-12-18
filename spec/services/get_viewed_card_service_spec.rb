# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetViewedCardService, type: :service do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }

  describe '.call' do
    it 'returns card when pass id' do
      viewed_card = GetViewedCardService.call(user, card.id)
      expect(viewed_card).to eq(card)
    end
  end
end
