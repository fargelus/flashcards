# frozen_string_literal: true

class DecksController < ApplicationController
  before_action :fetch_deck, only: %i[edit update destroy]
  helper_method :decks?

  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.new
  end

  def edit; end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path, notice: I18n.t(:deck_updated)
    else
      render 'edit'
    end
  end

  def create
    @deck = Deck.new(deck_params)

    if @deck.save
      redirect_to decks_path, notice: I18n.t(:deck_created)
    else
      render 'new'
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  private

  def decks?
    Deck.count.positive?
  end

  def fetch_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(
      :name,
      :description,
      :activity
    )
  end
end
