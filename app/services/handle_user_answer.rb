# frozen_string_literal: true

class HandleUserAnswer
  include CardsHelper

  def initialize(answer, card = nil)
    @answer = answer
    @card = card || Card.find(@answer.card_id)
  end

  def start
    if translation_correct?
      update_card_date
    else
      @answer.wrong = true
      @answer.save!
    end
  end

  def translation_correct?
    @answer.answer == @card.translated_text
  end

  private

  def update_card_date
    @card.review_date = days_after(3)
    @card.save!
  end
end
