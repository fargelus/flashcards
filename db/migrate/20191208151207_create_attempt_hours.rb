# frozen_string_literal: true

class CreateAttemptHours < ActiveRecord::Migration[5.0]
  def change
    create_table :attempt_hours do |t|
      t.integer :attempt
      t.integer :next_attempt_in_hours

      t.timestamps
    end
  end
end
