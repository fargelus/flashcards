# frozen_string_literal: true

class AttemptHourSeed
  def initialize
    @dict = []
    @init_hours = 12
    @ratios = {
      1 => 1,
      2 => 6,
      3 => 14,
      4 => 28,
      5 => 56
    }
  end

  def seed
    fill_dict_data
    AttemptHour.destroy_all
    AttemptHour.import @dict
  end

  def fill_dict_data
    1.upto(5) do |i|
      record = {}
      ratio = @ratios[i]
      hours = @init_hours * ratio
      record['attempt'] = i
      record['next_attempt_in_hours'] = hours
      @dict << record
    end
  end
end

AttemptHourSeed.new.seed
