# frozen_string_literal: true

FactoryBot.define do
  factory :repetition_interval do
    interval { 5 }
    e_factor { 2.5 }

    association :card, factory: :card
  end
end
