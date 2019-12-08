# frozen_string_literal: true

class UserAnswerHandler < ApplicationService
  include CardsHelper

  def initialize(answer, card = nil)
    @answer = answer
    card ||= Card.find(@answer.card_id)
    @card = card
  end

  def call
    result = false
    if translation_correct?
      update_card
      result = true
    else
      @answer.wrong = true
      @answer.save!
    end

    result
  end

  private

  def translation_correct?
    @answer.answer == @card.translated_text
  end

  def update_card
    set_attempts
    card_checks = CardCheck.find_by_attempt(@attempts)
    next_attempt_through = card_checks.next_attempt_in_hours
    @card.review_date = hours_after(next_attempt_through)
    @card.attempts_count = @attempts
    @card.save!
  end

  def set_attempts
    @attempts = @card.attempts_count + 1
    total_attempts = CardCheck.count
    @attempts = total_attempts if total_attempts < @attempts
  end
end
