# frozen_string_literal: true

# Service to determine next viewed card

class GetViewedCardService < Callable
  def initialize(user)
    @user = user
    fetch_card_for_review
  end

  def call
    @card
  end

  private

  def fetch_card_for_review
    decks_ids = User.active_deck(@user) || User.all_decks_id(@user)
    @card = Card.need_review(decks_ids).first
  end
end
