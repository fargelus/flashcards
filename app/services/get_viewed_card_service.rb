# frozen_string_literal: true

# Service for determine next viewed card

class GetViewedCardService < Callable
  def initialize(user, card_id)
    @user = user
    @card = Card.find_by(id: card_id)
    fetch_card_for_review unless last_answer_with_typo?
  end

  def call
    @card
  end

  private

  def last_answer_with_typo?
    @card&.answers&.last&.typo
  end

  def fetch_card_for_review
    decks_ids = User.active_deck(@user) || User.all_decks_id(@user)
    @card = Card.need_review(decks_ids).first
  end
end
