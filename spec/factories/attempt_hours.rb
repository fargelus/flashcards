# frozen_string_literal: true

FactoryBot.define do
  factory :attempt_hour do
    attempt { 1 }
    next_attempt_in_hours { 1 }
  end
end
