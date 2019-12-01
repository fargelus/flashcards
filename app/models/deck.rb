# frozen_string_literal: true

class Deck < ApplicationRecord
  before_update :reset_records_activity, if: :activity
  has_many :cards

  validates :name, presence: true, uniqueness: true

  private

  def reset_records_activity
    self.class.update_all("activity = 'false'")
  end
end
