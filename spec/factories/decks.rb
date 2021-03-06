# frozen_string_literal: true

FactoryBot.define do
  factory :deck do
    name { 'MyString' }
    description { 'MyString' }
    activity { false }

    association :user, factory: :user
  end
end
