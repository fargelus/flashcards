# Model for cards
# frozen_string_literal: true

class Card < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  scope :need_review, lambda {
    where('review_date <= ?', Date.today)
      .order(:review_date)
      .first
  }

  validates :original_text, :translated_text, :review_date, presence: true
  validates :original_text, uniqueness: true

  include ActiveModel::Validations
  validates_with CompareFieldsValidator
end
