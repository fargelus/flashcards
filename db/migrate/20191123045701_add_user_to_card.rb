# frozen_string_literal: true

class AddUserToCard < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :user, foreign_key: true
  end
end
