# frozen_string_literal: true

FactoryBot.define do
  factory :repetition_interval do
    interval { 5 }
    EF { 2.5 }

    association :card, factory: :card
  end
end
