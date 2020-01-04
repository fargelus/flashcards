# frozen_string_literal: true

# Service updates card next review date.
# It uses RepetitionInterval model within.

class UpdateCardReviewDateService < Callable
  include CardsHelper

  def initialize(card_id, quality)
    @card = Card.find(card_id)
    @quality = quality
    RepetitionIntervalCreator.call(card_id, quality)
  end

  def call
    interval = RepetitionInterval.last_interval(@card.id)
    @card.review_date = hours_after(interval)
    @card.save!
  end
end
