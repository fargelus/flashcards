# This will generate password sequence
# frozen_string_literal: true

FactoryBot.define do
  sequence :password do |_n|
    Array.new(6).map { rand(9) }.join('')
  end
end
