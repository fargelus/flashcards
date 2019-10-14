# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :original_text, null: false
      t.text :translated_text, null: false
      t.date :review_date, null: false

      t.timestamps null: false
    end
  end
end
