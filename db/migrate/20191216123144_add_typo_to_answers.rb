# frozen_string_literal: true

class AddTypoToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :typo, :boolean, default: false
  end
end
