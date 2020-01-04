# frozen_string_literal: true

# Service that determine previous user answer.
# If answer doesn't exist, it creates new one.

class PrevUserAnswerService < Callable
  def initialize(card)
    @card = card
    @answer = Answer.new
    last_answer = card.answers.last
    @answer = last_answer if last_answer&.typo
  end

  def call
    @answer
  end
end
