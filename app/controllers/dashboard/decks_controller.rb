# Controller for card's deck
# frozen_string_literal: true

class Dashboard::DecksController < ApplicationController
  before_action :fetch_deck, only: %i[edit update destroy]
  helper_method :decks?

  def index
    @decks = current_user.decks.all
  end

  def new
    @deck = current_user.decks.new
  end

  def edit; end

  def update
    if @deck.update(deck_params)
      redirect_to dashboard_decks_path, notice: I18n.t(:deck_updated)
    else
      render 'edit'
    end
  end

  def create
    @deck = current_user.decks.new(deck_params)

    if @deck.save
      redirect_to dashboard_decks_path, notice: I18n.t(:deck_created)
    else
      render 'new'
    end
  end

  def destroy
    @deck.destroy
    redirect_to dashboard_decks_path
  end

  private

  def decks?
    current_user.decks.count.positive?
  end

  def fetch_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(
      :name,
      :description,
      :activity
    )
  end
end
