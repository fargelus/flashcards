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
    create_answer if @card.present?
  end

  def define_next_card
    @card = GetViewedCardService.call(current_user, session[:guess_card_id])

    # In case of delete reviewing card
    session[:guess_card_id] = nil
  end

  def create_answer
    @answer = UserAnswerCreator.call(@card)
    show_notice_if_necessary
    SetAnswerTypoService.call(@answer) if @answer.typo
  end

  def show_notice_if_necessary
    last_answer = @card.answers.last
    need_notice = last_answer.need_notice
    notice = AnswerNoticeCreator.call(last_answer) if need_notice
    flash.now[notice[:status]] = notice[:text] if notice
  end
end
