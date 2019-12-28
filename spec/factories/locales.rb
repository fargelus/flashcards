# frozen_string_literal: true

FactoryBot.define do
  factory :locale do
    locale { 'en' }

    association :user, factory: :user
  end
end
