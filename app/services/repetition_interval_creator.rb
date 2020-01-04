# frozen_string_literal: true

# Service creates one instance for RepetitionInterval model.

class RepetitionIntervalCreator < Callable
  include EFactorValues

  def initialize(card_id, quality)
    @interval = RepetitionInterval.new
    @interval.card_id = card_id
    @quality = quality
    @current_e_factor = current_e_factor card_id
  end

  def call
    set_interval_value
    set_e_factor
    @interval.save!
  end

  private

  def set_interval_value
    card_id = @interval.card_id
    @interval.interval = CalcNextRepeatIntervalService.call(
      card_id,
      @current_e_factor
    )
  end

  def set_e_factor
    @interval.e_factor = e_factor_value
  end

  def e_factor_value
    CalcEFactorService.call(@current_e_factor, @quality)
  end

  def current_e_factor(card_id)
    RepetitionInterval.last_e_factor(card_id) || DEFAULT_E_FACTOR
  end
end
