# frozen_string_literal: true

class ChangeAttemptHoursToRepetitionIntervals < ActiveRecord::Migration[5.0]
  def change
    rename_table :attempt_hours, :repetion_intervals
    rename_column :repetion_intervals, :attempt, :attempts
    rename_column :repetion_intervals, :next_attempt_in_hours, :interval
    add_column :repetion_intervals, :EF, :decimal, default: 2.5
  end
end
