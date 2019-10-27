# Model for cards
# frozen_string_literal: true

class Card < ActiveRecord::Base
  scope :need_review, -> { where('review_date <= ?', Date.today) }
  scope :random_record, -> { order('RANDOM()').first }

  validates :original_text, :translated_text, :review_date, presence: true
  validates :original_text, uniqueness: true

  include ActiveModel::Validations
  validates_with CompareFieldsValidator
end
