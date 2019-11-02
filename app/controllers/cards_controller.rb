# Controller for cards resources
# frozen_string_literal: true

class CardsController < ApplicationController
  include CardsHelper

  before_action :fetch_card, only: %i[edit update destroy check_answer]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def edit; end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to cards_path, notice: I18n.t(:card_created)
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

  def check_answer
    user_answer = params[:card][:answer]
    if user_answer == @card.translated_text
      update_card_date
      redirect_to root_path, notice: I18n.t(:correct_answer)
    else
      redirect_to root_path(wrong_answer: true), notice: I18n.t(:wrong_answer)
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end

  def fetch_card
    @card = Card.find(params[:id])
  end

  def update_card_date
    @card.review_date = days_after(3)
    @card.save!
  end
end
