# Model for cards
# frozen_string_literal: true

class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validates :original_text, uniqueness: true

  include ActiveModel::Validations
  validates_with CompareFieldsValidator
end
