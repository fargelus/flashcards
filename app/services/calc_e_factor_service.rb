# frozen_string_literal: true

class CalcEFactorService < Callable
  def initialize(prev_e_factor, answer_quality)
    @prev_e_factor = prev_e_factor
    @answer_quality = answer_quality
  end

  def call
    @prev_e_factor + (0.1 - (5 - @answer_quality) * (0.08 + (5 - @answer_quality) * 0.02))
  end
end
