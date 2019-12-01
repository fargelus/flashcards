# frozen_string_literal: true

module DecksHelper
  def cards?(deck)
    deck.cards.count.positive?
  end
end
