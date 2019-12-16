# frozen_string_literal: true

# Service to skip typo flag for answer

class SkipAnswerTypoService < ApplicationService
  def initialize(answer)
    @answer = answer
  end

  def call
    @answer.typo = false
    @answer.save!
  end
end
