# User model
# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  mount_uploader :avatar, AvatarUploader

  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :email, :password, :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, length: { minimum: 6 }, confirmation: true

  scope :all_decks_id, lambda { |user|
    user.decks.select(:id).to_a
  }

  scope :active_deck, lambda { |user|
    user.decks.find_by_activity(true)
  }
end
