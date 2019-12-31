# frozen_string_literal: true

class AddQualityToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :quality, :integer
  end
end
