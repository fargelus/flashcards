# Model for cards
# frozen_string_literal: true

class Card < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :original_text,
      %i[original_text deck_id]
    ]
  end

  has_many :answers, dependent: :destroy
  has_many :attempt, dependent: :destroy
  belongs_to :deck
  mount_uploader :image, ImageUploader

  scope :need_review, lambda { |decks_ids|
    relation = where('review_date <= ? AND deck_id IN (?)',
                     Time.now, decks_ids)
               .order(:review_date)
    relation.present? ? relation.first : relation
  }

  validates :original_text, :translated_text, :review_date, presence: true
  validates :original_text, uniqueness: { scope: :deck_id }

  include ActiveModel::Validations
  validates_with CompareFieldsValidator
end
