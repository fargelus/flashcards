# frozen_string_literal: true

class CreateAttempts < ActiveRecord::Migration[5.0]
  def change
    create_table :attempts do |t|
      t.integer :success, default: 0
      t.integer :failure, default: 0
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
