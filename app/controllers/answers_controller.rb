# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.card_id = params[:card_id]
    @answer.wrong = !CheckAnswerService.call(@answer)
    @answer.quality = AnswerQualityBuilder.call(@answer, params[:guess_time])
    @answer.save!

    UpdateCardReviewDateService.call(@answer.card_id, @answer.quality)

    make_notice
    session[:guess_card_id] = @answer.card_id
    redirect_to root_path
  end

  def update
    answer = Answer.find(params[:id])
    SetAnswerTypoService.call(answer)
    redirect_to root_path
  end

  private

  def answer_params
    params.require(:answer).permit(:phrase, :answer)
  end

  def make_notice
    notice = AnswerNoticeCreator.call(@answer)
    flash[notice[:status]] = notice[:text]
  end
end
