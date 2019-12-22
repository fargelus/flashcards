# frozen_string_literal: true

# Service to determine next viewed card

class GetViewedCardService < Callable
  def initialize(user, card_id)
    @user = user
    @card = Card.find_by_id(card_id) if card_id
    fetch_card_for_review if need_review?
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
    return false if last_answer.nil?

    !last_answer.wrong && !last_answer.typo
  end

  def fetch_card_for_review
    decks_ids = User.active_deck(@user) || User.all_decks_id(@user)
    @card = Card.need_review(decks_ids).first
  end
end
