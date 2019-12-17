# frozen_string_literal: true

# Service that determine next user answer

class UserAnswerCreator < ApplicationService
  def initialize(card)
    @card = card
    @answer = Answer.new
    @card = card.answers.last if @card.answers.last.typo
  end

  def call
    @answer
  end
end
