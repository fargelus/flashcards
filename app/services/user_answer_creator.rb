# frozen_string_literal: true

# Service that determine next user answer

class UserAnswerCreator < ApplicationService
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
