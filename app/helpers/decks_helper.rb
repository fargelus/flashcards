# frozen_string_literal: true

module DecksHelper
  def deck_name(deck)
    deck.name.capitalize
  end
end
