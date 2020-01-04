# frozen_string_literal: true

# Service for handle user answer to the card.
#
# If user entered correct answer then service sets
# next date for card review.
# Otherwise number of failure attempts increased.
# Returns true if answer correct

class CheckAnswerService < Callable
  def initialize(answer, card = nil)
    @answer = answer
    card ||= Card.find(@answer.card_id)
    @card = card
  end

  def call
    answer_counted?
  end

  private

  def answer_counted?
    has_typos = CheckTyposService.call(@answer, @card)
    SetAnswerTypoService.call(@answer, has_typos)
    has_typos || right_answer?
  end

  def right_answer?
    @answer.answer == @card.translated_text
  end
end
