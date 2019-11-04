# frozen_string_literal: true

# This will guess the Card class

FactoryBot.define do
  factory :card do
    original_text { 'original_text' }
    translated_text { 'translated_text' }
    review_date { Date.today }
  end
end
