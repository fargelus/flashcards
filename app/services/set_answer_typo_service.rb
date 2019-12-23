# frozen_string_literal: true

# Service for setting answer's typo flag

class SetAnswerTypoService < Callable
  def initialize(answer, value = false)
    @answer = answer
    @value = value
  end

  def call
    @answer.typo = @value
    @answer.save!
  end
end
