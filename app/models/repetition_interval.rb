# frozen_string_literal: true

class RepetitionInterval < ApplicationRecord
  belongs_to :card
  validates :interval, :EF, :card, presence: true

  scope :card_intervals, lambda { |card_id|
    where("card_id = #{card_id}")
  }

  scope :last_interval, lambda { |card_id|
    record = card_intervals(card_id)
    return nil if record.blank?

    record.last.interval
  }

  scope :last_e_factor, lambda { |card_id|
    record = card_intervals(card_id)
    return nil if record.blank?

    record.last.EF
  }
end
