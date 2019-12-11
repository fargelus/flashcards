# frozen_string_literal: true

# Service for attempt's model attributes manipulation.
#
# Resets success/failures attributes to zero under certain conditions.

class AttemptService < ApplicationService
  def initialize(card_id, success: nil, failure: nil)
    @attempt = Attempt.find_by(card_id: card_id)
    @attempt ||= Attempt.create!(card_id: card_id)
    @attempt_success = success
    @attempt_failure = failure
  end

  def call
    reset_attempts_count if attempts_count_reset?
    reset_failure if attempt_success?
    update_attempt
  end

  private

  def attempts_count_reset?
    zero_params = @attempt_success.zero? && @attempt_failure.zero?
    many_failures? || zero_params
  end

  def many_failures?
    @attempt.failure == 3
  end

  def reset_attempts_count
    @attempt.success = 0
    reset_failure
  end

  def reset_failure
    @attempt.failure = 0
  end

  def attempt_success?
    @attempt_success.present? && @attempt_success.positive?
  end

  def update_attempt
    @attempt.success += @attempt_success if @attempt_success.present?
    @attempt.failure += @attempt_failure if @attempt_failure.present?
    @attempt.save!
  end
end
