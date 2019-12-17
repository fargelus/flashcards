# frozen_string_literal: true

# Service to determine next viewed card

class GetViewedCardService < ApplicationService
  def initialize(user, card_id)
    @user = user
    @card = Card.find_by_id(card_id) if card_id
    fetch_card_for_review if need_review
  end

  def call
    @card
  end

  private

  def need_review
    @card.nil? || @card.answers.last.wrong == false
  end

  def fetch_card_for_review
    decks_ids = User.active_deck(@user) || User.all_decks_id(@user)
    @card = Card.need_review(decks_ids)
  end
end
