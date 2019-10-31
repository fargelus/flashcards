# frozen_string_literal: true

class HomeController < ApplicationController
  include CardsHelper

  def index
    if session[:guess_card_text]
      @guess_card_text = session[:guess_card_text]
      @wrong_answer = true
    else
      @card = Card.need_review.random_record
      @guess_card_text = @card.original_text

      session[:guess_card_text] = @card.original_text
      session[:answer] = @card.translated_text
    end
  end

  def check_answer
    user_answer = params[:card][:answer]
    if user_answer == session[:answer]
      session[:guess_card_text] = nil
      update_card_date(user_answer)
      redirect_to root_path, notice: I18n.t(:correct_answer)
    else
      redirect_to root_path, notice: I18n.t(:wrong_answer)
    end
  end

  def next_card
    session[:guess_card_text] = nil
    redirect_to root_path
  end

  private

  def update_card_date(tr_text)
    @card = Card.find_by translated_text: tr_text
    @card.review_date = days_after(3)
    @card.save
  end
end
