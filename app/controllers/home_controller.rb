# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    define_next_card
    @answer = Answer.new
    @guess_card_text = @card.original_text unless @card.blank?
  end

  private

  def define_next_card
    answered_card_id = session[:guess_card_id]
    if answered_card_id
      @card = Card.find(answered_card_id)
      @last_answer = @card.answers.last
      process_last_answer
    else
      fetch_card_for_review
    end
  end

  def process_last_answer
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
    @card = Card.need_review
  end
end
