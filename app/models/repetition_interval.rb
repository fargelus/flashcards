# frozen_string_literal: true

class RepetitionInterval < ApplicationRecord
  belongs_to :card
  validates :interval, :EF, :card, presence: true

  scope :card_intervals, lambda { |card_id|
    where("card_id = #{card_id}")
  }

  def self.last_interval(card_id)
    card_intervals(card_id).last&.interval
  end

  def self.last_e_factor(card_id)
    card_intervals(card_id).last&.EF
  end
end
