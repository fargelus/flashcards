# frozen_string_literal: true

class CalcEFactorService < Callable
  MINIMUM_E_FACTOR = 1.3

  def initialize(prev_e_factor, answer_quality)
    @prev_e_factor = prev_e_factor
    @answer_quality = answer_quality
  end

  def call
    value = e_factor_formula
    value = MINIMUM_E_FACTOR if value < MINIMUM_E_FACTOR
    value
  end

  private

  def e_factor_formula
    @prev_e_factor + (0.1 - (5 - @answer_quality) * (0.08 + (5 - @answer_quality) * 0.02))
  end
end
