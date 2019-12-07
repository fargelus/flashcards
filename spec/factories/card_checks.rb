# frozen_string_literal: true

FactoryBot.define do
  factory :card_check do
    attempt { '' }
    next_attempt_in_hours { '' }
  end
end
