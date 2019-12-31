# frozen_string_literal: true

class AddCardToRepetionIntervals < ActiveRecord::Migration[5.0]
  def change
    add_reference :repetion_intervals, :card, foreign_key: true
  end
end
