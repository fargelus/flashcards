# frozen_string_literal: true

class UserAnswerHandler < ApplicationService
  include CardsHelper

  def initialize(answer, card = nil)
    @answer = answer
    card ||= Card.find(@answer.card_id)
    @card = card
    @attempt = Attempt.find_by_card_id(@card.id)
    @attempt ||= Attempt.create(card_id: @card.id)
  end

  def call
    result = false
    if translation_correct?
      update_card
      result = true
    else
      wrong_answer
    end

    result
  end

  private

  def translation_correct?
    @answer.answer == @card.translated_text
  end

  def update_card
    @attempt.success += 1
    next_attempt_through = AttemptHour.get_attempt_hours(@attempt.success)
    @card.review_date = hours_after(next_attempt_through)
    @card.save!
  end

  def wrong_answer
    @attempt.failure += 1
    @answer.wrong = true
    @attempt.save!
    @answer.save!
  end
end
