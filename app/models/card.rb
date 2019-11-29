# Model for cards
# frozen_string_literal: true

class Card < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  mount_uploader :image, ImageUploader

  scope :need_review, lambda {
    relation = where('review_date <= ?', Date.today)
               .order(:review_date)
    relation.present? ? relation.first : relation
  }

  validates :original_text, :translated_text, :review_date, presence: true
  validates :original_text, uniqueness: { scope: :user_id }

  include ActiveModel::Validations
  validates_with CompareFieldsValidator
end
