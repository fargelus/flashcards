# This will generate random phrase
# frozen_string_literal: true

FactoryBot.define do
  sequence :phrase do |_n|
    Array.new(8).map { rand(65..90).chr }.join('')
  end
end
