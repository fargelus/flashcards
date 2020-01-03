# This will guess the Answer class
# frozen_string_literal: true

include AnswerQualityGrades

FactoryBot.define do
  factory :answer do
    phrase { 'phrase' }
    answer { 'answer' }
    quality { PERFECT_RESPONSE }

    association :card_id, factory: :card
  end
end
