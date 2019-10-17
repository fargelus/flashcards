# Controller for cards resources
# frozen_string_literal: true

class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.create(card_params)
    if @card.errors.empty? && @card.save
      redirect_to action: "index"
    else
      render 'new'
    end
  end

  private
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
end
