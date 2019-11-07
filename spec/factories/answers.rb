# This will guess the Answer class
# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    phrase { 'phrase' }
    answer { 'answer' }

    association :card_id, factory: :card
  end
end
