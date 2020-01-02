# frozen_string_literal: true

class CalcNextRepeatIntervalService < Callable
  RATIO = 5

  def initialize(card_id, ef)
    @card_id = card_id
    @EF = ef
    @intervals = RepetitionInterval.card_intervals(card_id)
  end

  def call
    amount = @intervals.count
    return amount * RATIO + 1 if amount < 2

    last_interval = RepetitionInterval.last_interval(@card_id)
    (last_interval * @EF).to_i
  end
end
