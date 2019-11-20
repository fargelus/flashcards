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
      update_card_date
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

  def update_card_date
    @card.review_date = days_after(3)
    @card.save!
  end
end
