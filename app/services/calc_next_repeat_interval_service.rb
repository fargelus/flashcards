# frozen_string_literal: true

class CalcNextRepeatIntervalService < Callable
  RATIO = 5

  def initialize(card_id, factor)
    @card_id = card_id
    @e_factor = factor
    @intervals = RepetitionInterval.card_intervals(card_id)
  end

  def call
    attempts = @intervals.count
    return attempts * RATIO + 1 if attempts < 2

    last_interval = RepetitionInterval.last_interval(@card_id)
    (last_interval * @e_factor).to_i
  end
end
