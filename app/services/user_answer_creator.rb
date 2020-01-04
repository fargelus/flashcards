# frozen_string_literal: true

class UserAnswerCreator < Callable
  def initialize(params, guess_time)
    @params = params
    @guess_time = guess_time
  end

  def call
    answer = Answer.new(@params)
    answer.wrong = !CheckAnswerService.call(answer)
    answer.quality = AnswerQualityBuilder.call(answer, @guess_time)
    answer.save!
    UpdateCardReviewDateService.call(answer.card_id, answer.quality)
    answer
  end
end
