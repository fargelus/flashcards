# frozen_string_literal: true

class HomeController < ApplicationController
  include ApplicationHelper

  skip_before_action :require_login, only: [:index]

  def index
    access_allowed if user_with_cards?
  end

  private

  def user_with_cards?
    current_user && cards?(current_user)
  end

  def access_allowed
    define_next_card
    @answer = Answer.new
    @guess_card_text = @card.original_text unless @card.blank?
  end

  def define_next_card
    answered_card_id = session[:guess_card_id]
    if answered_card_id
      @card = Card.find_by_id(answered_card_id)
      process_last_answer if @card
    else
      fetch_card_for_review
    end

    # In case of delete reviewing card
    session[:guess_card_id] = nil
  end

  def process_last_answer
    @last_answer = @card.answers.last
    is_wrong = @last_answer.wrong
    if @last_answer.need_notice
      define_notice_text(is_wrong)
      notice_done
    end

    fetch_card_for_review unless is_wrong
  end

  def define_notice_text(last_answer_was_wrong)
    if last_answer_was_wrong
      flash.now[:notice] = I18n.t(:wrong_answer)
      @wrong_answer = true
    else
      flash.now[:notice] = I18n.t(:correct_answer)
    end
  end

  def notice_done
    @last_answer.need_notice = false
    @last_answer.save!
  end

  def fetch_card_for_review
    decks_ids = current_deck&.id || all_user_decks_id
    @card = Card.need_review(decks_ids)
  end

  def all_user_decks_id
    current_user.decks.select(:id).to_a
  end
end
