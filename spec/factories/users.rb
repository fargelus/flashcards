# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@mail.com' }
    password { '1234567890' }
    password_confirmation { '1234567890' }
  end
end
