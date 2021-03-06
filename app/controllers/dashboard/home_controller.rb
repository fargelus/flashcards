# frozen_string_literal: true

module Dashboard
  class HomeController < ApplicationController
    def index
      define_next_card
      @answer = PrevUserAnswerService.call(@card) if @card.present?
      make_response
    end

    private

    def define_next_card
      @card = GetViewedCardService.call(current_user, session[:guess_card_id])
      session[:guess_card_id] = nil
    end

    def make_response
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
