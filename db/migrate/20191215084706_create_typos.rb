# frozen_string_literal: true

class CreateTypos < ActiveRecord::Migration[5.0]
  def change
    create_table :typos do |t|
      t.boolean :presence, default: false
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
