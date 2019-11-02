# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    answer = Answer.new(answer_params)
    answer.save!
    redirect_to root_path
  end

  private

  def answer_params
    params.require(:answer).permit(:phrase, :answer)
  end
end
