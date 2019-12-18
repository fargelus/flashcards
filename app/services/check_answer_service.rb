# frozen_string_literal: true

# Service for handle user answer to the card.
#
# If user entered correct answer then service sets
# next date for card review.
# Otherwise number of failure attempts increased.
# Returns true if answer correct

class CheckAnswerService < ApplicationService
  include CardsHelper

  def initialize(answer, card = nil)
    @answer = answer
    card ||= Card.find(@answer.card_id)
    @card = card
    @check_result = 0
  end

  def call
    if translation_correct?
      @check_result = 1
      update_card
    end

    update_answer
    failure = 1 if @check_result.zero?
    AttemptService.call(@card.id, success: @check_result, failure: failure)
    @check_result.positive?
  end

  private

  def translation_correct?
    has_typos = CheckTyposService.call(@answer, @card)
    SetAnswerTypoService.call(@answer, has_typos)
    has_typos || right_answer?
  end

  def right_answer?
    @answer.answer == @card.translated_text
  end

  def update_card
    @attempt = Attempt.find_by(card_id: @card.id)
    next_attempt_through = AttemptHour.attempt_hours(@attempt.success + 1)
    @card.review_date = hours_after(next_attempt_through)
    @card.save!
  end

  def update_answer
    @answer.wrong = @check_result.zero?
    @answer.save!
  end
end
