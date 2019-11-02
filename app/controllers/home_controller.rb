# frozen_string_literal: true

class HomeController < ApplicationController
  @@saved_card = nil

  def index
    wrong_answer = params[:wrong_answer]
    if wrong_answer
      @card = @@saved_card
      @wrong_answer = true
    else
      @card = Card.need_review.random_record
      @@saved_card = @card
    end
  end
end
