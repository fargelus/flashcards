# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @card = Card.need_review.random_record
    @last_answer = Answer.last
    process_last_answer if @last_answer

    @answer = Answer.new
    @guess_card_text = @card.original_text
  end

  private

  def process_last_answer
    is_need_notice = @last_answer.need_notice
    is_wrong = @last_answer.wrong
    if is_need_notice
      define_notice_text(is_wrong)
      notice_done
    end

    get_previous_unguess_card if is_wrong
  end

  def get_previous_unguess_card
    card_id = @last_answer.card_id
    @card = Card.find(card_id)
  end

  def define_notice_text(last_answer_was_wrong)
    if last_answer_was_wrong
      flash[:notice] = I18n.t(:wrong_answer)
      @wrong_answer = true
    else
      flash[:notice] = I18n.t(:correct_answer)
    end
  end

  def notice_done
    @last_answer.need_notice = false
    @last_answer.save!
  end
end
