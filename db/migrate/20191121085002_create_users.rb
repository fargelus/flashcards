# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }, null: false
      t.string :crypted_password, limit: 20
      t.string :salt

      t.timestamps
    end
  end
end
