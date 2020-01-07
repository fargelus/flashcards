# frozen_string_literal: true

class Dashboard::AnswersController < ApplicationController
  def create
    @answer = UserAnswerCreator.call(answer_params, params[:guess_time])
    make_notice
    session[:guess_card_id] = params[:card_id]
    redirect_to dashboard_root_path
  end

  def update
    answer = Answer.find(params[:id])
    SetAnswerTypoService.call(answer)
    redirect_to dashboard_root_path, status: 303
  end

  private

  def answer_params
    all_params = params.require(:answer).permit(:phrase, :answer)
    all_params[:card_id] = params[:card_id]
    all_params
  end

  def make_notice
    notice = AnswerNoticeCreator.call(@answer)
    flash[notice[:status]] = notice[:text]
  end
end
