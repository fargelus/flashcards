# frozen_string_literal: true

class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string :name
      t.text :description
      t.boolean :activity, :default => false

      t.timestamps
    end
  end
end