# frozen_string_literal: true

class CardChecksSeed
  def initialize
    @dict = {}
    fill_data
  end

  def fill_data
    init_hours = 12
    ratios = {
      1 => 1,
      2 => 3,
      3 => 14,
      4 => 28,
      5 => 56
    }

    1.upto(5) do |i|
      ratio = ratios[i]
      hours = init_hours * ratio
      @dict[i] = hours
    end
  end
end

CardChecksSeed.new
