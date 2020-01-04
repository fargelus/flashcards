# frozen_string_literal: true

# Service for calculating E_FACTOR value which part of
# repetition interval formula.

class CalcEFactorService < Callable
  include AnswerQualityGrades
  include EFactorValues

  E_FACTOR_DIFFERENCE = 0.8
  QUALITY_PART_RATIO = 0.28
  DOUBLED_QUALITY_RATIO = 0.02

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
    return MINIMUM_E_FACTOR if value < MINIMUM_E_FACTOR
    return DEFAULT_E_FACTOR if value > DEFAULT_E_FACTOR

    value
  end

  def e_factor_formula
    doubled_quality_part = DOUBLED_QUALITY_RATIO * @answer_quality**2
    quality_part = QUALITY_PART_RATIO * @answer_quality
    @prev_e_factor - E_FACTOR_DIFFERENCE + quality_part - doubled_quality_part
  end
end
