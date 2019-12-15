# frozen_string_literal: true

# Service to determine if the user made a typo

require 'damerau-levenshtein'

class CheckTyposService < ApplicationService
  def initialize(answer, card)
    @answer = answer
    @card = card
    @min_edits = 3
  end

  def call
    typos = typos?
    @answer.create_typo! if typos
    typos
  end

  private

  def typos?
    distance = DamerauLevenshtein.distance(@answer.answer, @card.translated_text)
    distance.positive? && distance <= @min_edits
  end
end
