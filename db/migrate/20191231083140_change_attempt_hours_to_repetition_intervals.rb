# frozen_string_literal: true

class ChangeAttemptHoursToRepetitionIntervals < ActiveRecord::Migration[5.0]
  def change
    rename_table :attempt_hours, :repetition_intervals
    remove_column :repetition_intervals, :attempt, :integer
    rename_column :repetition_intervals, :next_attempt_in_hours, :interval
    add_column :repetition_intervals, :e_factor, :decimal,
               precision: 5, scale: 3, default: 2.5
    add_reference :repetition_intervals, :card, foreign_key: true
  end
end
