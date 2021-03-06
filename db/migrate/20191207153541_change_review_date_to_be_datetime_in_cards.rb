# frozen_string_literal: true

class ChangeReviewDateToBeDatetimeInCards < ActiveRecord::Migration[5.0]
  def up
    change_column :cards, :review_date, :datetime
  end

  def down
    change_column :cards, :review_date, :date
  end
end
