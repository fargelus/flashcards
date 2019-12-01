# frozen_string_literal: true

class AddUserToDecks < ActiveRecord::Migration[5.0]
  def change
    add_reference :decks, :user, foreign_key: true
  end
end
