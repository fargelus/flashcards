# frozen_string_literal: true

# Service to determine if the user made a typo

require 'damerau-levenshtein'

class CheckTyposService < ApplicationService
  MIN_EDITS = 3

  def initialize(answer, card)
    @answer = answer
    @card = card
  end

  def call
    distance = DamerauLevenshtein.distance(@answer.answer, @card.translated_text)
    distance.positive? && distance <= MIN_EDITS
  end
end
