# frozen_string_literal: true

class DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.new
  end

  def create
    name = params.require(:deck).permit(:name)
    @deck = Deck.new(name)

    if @deck.save
      redirect_to decks_path, notice: I18n.t(:deck_created)
    else
      render 'new'
    end
  end
end
