# Controller for cards resources
# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :fetch_deck, only: %i[index new create]
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
      redirect_to deck_cards_path, notice: I18n.t(:card_created)
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path, notice: I18n.t(:card_updated)
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy

    redirect_to cards_path
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
    @card = current_user.cards.friendly.find(params[:id])
  end

  def fetch_deck
    @deck = Deck.find(params[:deck_id])
  end
end
