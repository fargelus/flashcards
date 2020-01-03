# frozen_string_literal: true

# Service for calculating E_FACTOR value which part of
# repetition interval formula.

class CalcEFactorService < Callable
  include AnswerQualityGrades
  MINIMUM_E_FACTOR = 1.3
  DEFAULT_E_FACTOR = 2.5

  def initialize(prev_e_factor, answer_quality)
    @prev_e_factor = prev_e_factor
    @answer_quality = answer_quality
  end

  def call
    @answer_quality < DIFFICULT_RESPONSE ? DEFAULT_E_FACTOR : calc_e_factor
  end

  private

  def calc_e_factor
    value = e_factor_formula
    value = MINIMUM_E_FACTOR if value < MINIMUM_E_FACTOR
    value = DEFAULT_E_FACTOR if value > DEFAULT_E_FACTOR
    value
  end

  def e_factor_formula
    quality_updates = 5 - @answer_quality
    ratio = 0.08 + quality_updates * 0.02
    @prev_e_factor + 0.1 - quality_updates * ratio
  end
end
