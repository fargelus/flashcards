# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @card = Card.need_review.random_record
    @guess_card_text = @card.original_text + '?'
  end
end
