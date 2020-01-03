# This will guess the Answer class
# frozen_string_literal: true

FactoryBot.define do
  AnswerQualities = Class.new { include AnswerQualityGrades }

  factory :answer do
    phrase { 'phrase' }
    answer { 'answer' }
    quality { AnswerQualities::PERFECT_RESPONSE }

    association :card_id, factory: :card
  end
end
