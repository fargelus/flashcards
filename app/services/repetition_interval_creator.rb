# frozen_string_literal: true

class RepetitionIntervalCreator < Callable
  DEFAULT_E_FACTOR = 2.5

  def initialize(card_id, quality)
    @interval = RepetitionInterval.new
    @interval.card_id = card_id
    @quality = quality
  end

  def call
    set_e_factor
    set_interval_value
    @interval.save!
  end

  private

  def set_e_factor
    card_id = @interval.card_id
    existing_intervals = RepetitionInterval.card_intervals(card_id)
    if existing_intervals.count > 2
      prev_e_factor = RepetitionInterval.last_e_factor(card_id)
      @interval.EF = CalcEFactorService.call(prev_e_factor, @quality)
    else
      @interval.EF = DEFAULT_E_FACTOR
    end
  end

  def set_interval_value
    @interval.interval = 12
  end
end
