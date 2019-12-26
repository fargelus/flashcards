# frozen_string_literal: true

FactoryBot.define do
  factory :locale do
    locale { 'MyString' }
    user { nil }
  end
end
