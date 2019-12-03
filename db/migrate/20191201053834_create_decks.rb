# frozen_string_literal: true

class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :activity, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
