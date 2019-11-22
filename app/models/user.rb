# User model
# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :cards, dependent: :destroy

  validates :email, :crypted_password, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :crypted_password, length: { maximum: 20 }
end
