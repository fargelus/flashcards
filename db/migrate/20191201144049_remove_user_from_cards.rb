# frozen_string_literal: true

class RemoveUserFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_reference :cards, :user, foreign_key: true
  end
end
