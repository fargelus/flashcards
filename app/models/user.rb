# User model
# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :cards, dependent: :destroy

  validates :email, :password, :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, length: { minimum: 6 }, confirmation: true
end
