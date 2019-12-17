# frozen_string_literal: true

# Service to determine next viewed card

class GetViewedCardService < ApplicationService
  def initialize(user, card_id)
    @user = user
    @card = Card.find_by_id(card_id) if card_id
    # abort @card.answers.last.inspect
    # abort @card.answers.last.inspect
    fetch_card_for_review if need_review?
    # abort @card.inspect
  end

  def call
    @card
  end

  private

  def need_review?
    @card.nil? || last_answer_right?
  end

  def last_answer_right?
    last_answer = @card.answers.last
    !last_answer.wrong && !last_answer.typo
  end

  def fetch_card_for_review
    # abort 'fetch card'
    decks_ids = User.active_deck(@user) || User.all_decks_id(@user)
    @card = Card.need_review(decks_ids)
  end
end
