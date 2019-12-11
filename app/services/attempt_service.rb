# Service for attempt model attributes manipulation
# frozen_string_literal: true

class AttemptService < ApplicationService
  def initialize(attempt)
    @attempt = attempt
  end

  def call
    reset_failure if attempt_success?
    reset_attempts_count if many_failures?
  end

  def reset_attempts_count
    @attempt.success = 0
    reset_failure
  end

  private

  def attempt_success?
    saved_attempt = Attempt.find(@attempt.id)
    @attempt.success > saved_attempt.success if saved_attempt.present?
  end

  def reset_failure
    @attempt.failure = 0
  end

  def many_failures?
    @attempt.failure == 3
  end
end
