# frozen_string_literal: true

FactoryBot.define do
  factory :attempt do
    success { 1 }
    failure { 1 }

    association :card, factory: :card
  end
end
