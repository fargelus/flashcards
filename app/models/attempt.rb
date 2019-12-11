# Model for guess attempts countings
# frozen_string_literal: true

class Attempt < ApplicationRecord
  before_save :check_attributes

  belongs_to :card
  validates :card_id, presence: true
  validates :success, :failure, numericality: { only_integer: true }
  validates :card_id, uniqueness: true

  private

  def check_attributes
    AttemptService.call(self)
  end
end
