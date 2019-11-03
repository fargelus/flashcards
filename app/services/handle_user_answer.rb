class HandleUserAnswer
  include CardsHelper

  def initialize(answer)
    @answer = answer
    @card = Card.find(@answer.card_id)
  end

  def start
    if @answer.answer == @card.translated_text
      update_card_date
    else
      @answer.wrong = true
      @answer.save!
    end
  end

  private

  def update_card_date
    @card.review_date = days_after(3)
    @card.save!
  end
end
