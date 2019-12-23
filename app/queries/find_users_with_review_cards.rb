# Returns users with cards need to review
# frozen_string_literal: true

class FindUsersWithReviewCards < Callable
  def call
    review_cards = Card.need_review(Deck.ids)
    deck_ids = review_cards.pluck(:deck_id)
    user_ids = Deck.find(deck_ids).pluck(:user_id)
    User.find(user_ids)
  end
end
