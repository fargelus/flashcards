# frozen_string_literal: true

# Service for updating card's state

require 'damerau-levenshtein'

class CheckTyposService < ApplicationService
  def initialize(answer, card)
    @answer = answer
    @card = card
    @min_edits = 3
  end

  def call
    typos = typos?
    @answer.create_typo!(presence: true) if typos
    typos
  end

  private

  def typos?
    distance = DamerauLevenshtein.distance(@answer.answer, @card.translated_text)
    distance.positive? && distance <= @min_edits
  end
end
