# frozen_string_literal: true

# Service for updating card's state

class CardStateService < ApplicationService
  def initialize(card_id)
    @card = Card.find_by(id: card_id)
  end

  def update(params)
    @card.update(params)
  end
end
