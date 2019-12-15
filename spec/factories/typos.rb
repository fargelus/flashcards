# frozen_string_literal: true

FactoryBot.define do
  factory :typo do
    association :answer, factory: :answer
  end
end
