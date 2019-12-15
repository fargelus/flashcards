# frozen_string_literal: true

class TyposController < ApplicationController
  def show
    typo = Typo.find(params[:id])
    @answer = Answer.find(typo.answer_id)
    @card = Card.find(@answer.card_id)
  end
end
