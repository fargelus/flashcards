# frozen_string_literal: true

class HomeController < ApplicationController
  include ApplicationHelper

  skip_before_action :require_login, only: [:index]

  def index
    User.notify_about_cards
    access_allowed if user_with_cards?
  end

  private

  def user_with_cards?
    current_user && cards?(current_user)
  end

  def access_allowed
    define_next_card
    @answer = UserAnswerCreator.call(@card) if @card.present?
  end

  def define_next_card
    @card = GetViewedCardService.call(current_user, session[:guess_card_id])

    # In case of delete reviewing card
    session[:guess_card_id] = nil
  end
end
