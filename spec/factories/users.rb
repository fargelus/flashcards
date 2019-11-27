# frozen_string_literal: true

FactoryBot.define do
  pwd = 'secret'

  factory :user do
    email { 'test@mail.com' }
    password { pwd }
    password_confirmation { pwd }
  end
end
