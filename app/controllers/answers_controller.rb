# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    answer = Answer.new(answer_params)
    answer.card_id = params[:card_id]
    answer.need_notice = true
    answer.save!

    HandleUserAnswer.new(answer).start
    redirect_to root_path
  end

  private

  def answer_params
    params.require(:answer).permit(:phrase, :answer)
  end
end