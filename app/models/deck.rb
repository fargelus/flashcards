# Model for card's deck
# frozen_string_literal: true

class Deck < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :name,
      %i[name user_id]
    ]
  end

  before_update :reset_records_activity, if: :activity
  has_many :cards, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }

  private

  def reset_records_activity
    self.class.update_all("activity = 'false'")
  end
end
