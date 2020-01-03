# frozen_string_literal: true

FactoryBot.define do
  factory :authentication do
    provider { 'github' }
    uid { generate :phrase }

    association :user, factory: :user
  end
end
