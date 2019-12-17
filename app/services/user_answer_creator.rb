# frozen_string_literal: true

# Service that determine next user answer

class UserAnswerCreator < ApplicationService
  def initialize(card)
    @card = card
    @answer = Answer.new
    reassign_answer_if_typos
  end

  def call
    @answer
  end

  private

  def reassign_answer_if_typos
    last_answer = @card.answers.last
    if last_answer.typo
      @answer = last_answer.dup
      SetAnswerTypoService.call(last_answer)
    end
  end
end
