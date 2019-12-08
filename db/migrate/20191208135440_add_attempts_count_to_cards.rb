# frozen_string_literal: true

class AddAttemptsCountToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :attempts_count, :integer, default: 0
  end
end
