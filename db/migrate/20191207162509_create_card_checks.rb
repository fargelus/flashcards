# frozen_string_literal: true

class CreateCardChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :card_checks do |t|
      t.integer :attempt
      t.integer :next_attempt_in_hours

      t.timestamps
    end
  end
end
