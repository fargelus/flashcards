# Controller for cards resources
# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :fetch_deck
  before_action :fetch_card, only: %i[edit update destroy]

  def index
    @cards = @deck.cards.all
  end

  def new
    @card = @deck.cards.new
  end

  def edit; end

  def create
    @card = @deck.cards.new(card_params)
    if @card.save
      redirect_to deck_cards_path(@deck), notice: I18n.t(:card_created)
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      @attempt = Attempt.find_by_card_id(@card.id)
      @attempt.reset_attempts_count
      @attempt.save

      redirect_to deck_cards_path(@deck), notice: I18n.t(:card_updated)
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy

    redirect_to deck_cards_path(@deck)
  end

  private

  def card_params
    params.require(:card).permit(
      :original_text,
      :translated_text,
      :review_date,
      :image
    )
  end

  def fetch_card
    @card = Card.find(params[:id])
  end

  def fetch_deck
    @deck = Deck.find(params[:deck_id])
  end
end
