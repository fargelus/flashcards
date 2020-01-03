# frozen_string_literal: true

# This service determine quality of user answer.
# Quality depends on answer correction & time of response.

class AnswerQualityBuilder < Callable
  include AnswerQualityGrades
  include ResponseTimeMeasures

  def initialize(answer, guess_time)
    @answer = answer
    @guess_time = guess_time.to_i
  end

  def call
    return BAD_RESPONSE if @answer.wrong
    return typo_response if @answer.typo
    correct_response
  end

  private

  def typo_response
    @guess_time <= FAST_TYPO_RESPONSE ? FAST_TYPO_RESPONSE : SLOW_TYPO_RESPONSE
  end

  def correct_response
    if @guess_time <= FAST_RESPONSE_TIME
      PERFECT_RESPONSE
    elsif @guess_time <= DELAY_RESPONSE_TIME
      HESITATION_RESPONSE
    else
      DIFFICULT_RESPONSE
    end
  end
end
