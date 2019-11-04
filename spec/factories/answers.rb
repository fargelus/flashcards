# frozen_string_literal: true

# This will guess the Answer class

FactoryBot.define do
  factory :answer do
    phrase { 'phrase' }
    answer { 'answer' }
    association :card_id, factory: :card
  end
end
