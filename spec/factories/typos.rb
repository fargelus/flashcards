# frozen_string_literal: true

FactoryBot.define do
  factory :typo do
    presence { false }
    answer { nil }
  end
end
