# frozen_string_literal: true

class Attempt < ApplicationRecord
  before_save :reset_failure, if: :attempt_success?
  before_save :reset_attempts_count, if: :many_failures?

  belongs_to :card
  validates :card_id, presence: true
  validates :success, :failure, numericality: { only_integer: true }
  validates :card_id, uniqueness: true

  def reset_attempts_count
    self.success = 0
    reset_failure
  end

  private

  def attempt_success?
    saved_attempt = Attempt.find(id)
    success > saved_attempt.success
  end

  def reset_failure
    self.failure = 0
  end

  def many_failures?
    failure == 3
  end
end
