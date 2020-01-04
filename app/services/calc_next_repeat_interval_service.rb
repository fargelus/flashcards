# frozen_string_literal: true

# This service calculate next repeat interval for card.
# It returns default interval (between 1 and 6 hours) or
# process previous interval value for calculating new one.

class CalcNextRepeatIntervalService < Callable
  include AnswerQualityGrades
  RATIO = 5
  MINIMUM_INTERVAL = 1
  ATTEMPTS_WITH_DEFAULT_INTERVAL = 2

  def initialize(card_id, factor)
    @card_id = card_id
    @e_factor = factor
    @intervals = RepetitionInterval.card_intervals(card_id)
    @last_answer = Card.find(card_id).answers.last
    @intervals_count = @intervals.count
    @few_intervals = @intervals_count < ATTEMPTS_WITH_DEFAULT_INTERVAL
  end

  def call
    if default_interval?
      @few_intervals ? @intervals_count * RATIO + 1 : MINIMUM_INTERVAL
    else
      last_interval = RepetitionInterval.last_interval(@card_id)
      (last_interval * @e_factor).to_i
    end
  end

  private

  def default_interval?
    @few_intervals || @last_answer.quality < DIFFICULT_RESPONSE
  end
end
