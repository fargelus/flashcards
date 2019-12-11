# Model for guess attempts countings
# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :card
  validates :card_id, presence: true
  validates :success, :failure, numericality: { only_integer: true }
  validates :card_id, uniqueness: true
end
