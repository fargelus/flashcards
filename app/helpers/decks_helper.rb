# frozen_string_literal: true

module DecksHelper
  def cards?(deck)
    deck.cards.count.positive?
  end

  def deck_name(deck)
    deck.name.capitalize
  end
end
