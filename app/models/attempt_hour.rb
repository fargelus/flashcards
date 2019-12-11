# Model for mapping attempts to delay hours
# frozen_string_literal: true

class AttemptHour < ApplicationRecord
  validates :attempt, :next_attempt_in_hours, presence: true
  validates :attempt, :next_attempt_in_hours, numericality: { only_integer: true }
  validates :attempt, numericality: { less_than: 6 }

  scope :get_attempt_hours, lambda { |attempt|
    record = find_by(attempt: attempt) || last
    record.next_attempt_in_hours
  }
end
