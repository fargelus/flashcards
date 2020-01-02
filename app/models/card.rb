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
  has_many :repetition_intervals, dependent: :destroy
  belongs_to :deck
  mount_uploader :image, ImageUploader

  def self.need_review(decks_ids)
    where('review_date <= ? AND deck_id IN (?)',
          Time.now, decks_ids)
      .order(:review_date)
  end

  scope :last_answer, lambda { |id|
    Card.find(id).answers.last
  }

  validates :original_text, :translated_text, :review_date, presence: true
  validates :original_text, uniqueness: { scope: :deck_id }

  include ActiveModel::Validations
  validates_with CompareFieldsValidator
end
