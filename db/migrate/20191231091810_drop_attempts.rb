# frozen_string_literal: true

class DropAttempts < ActiveRecord::Migration[5.0]
  def change
    drop_table :attempts
  end
end
