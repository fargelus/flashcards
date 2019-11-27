# This will guess the Card class
# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    original_text { 'original_text' }
    translated_text { 'translated_text' }
    review_date { Date.today }

    association :user, factory: :user
  end
end
