# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.belongs_to :card

      t.string :phrase
      t.string :answer
      t.boolean :wrong
      t.boolean :need_notice

      t.timestamps
    end
  end
end
