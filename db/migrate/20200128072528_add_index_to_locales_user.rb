# frozen_string_literal: true

class AddIndexToLocalesUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :locales, :user_id
    add_reference :locales, :user, index: true, foreign_key: true
  end
end
