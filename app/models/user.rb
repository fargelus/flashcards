# User model
# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :authentications_attributes

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentification
  end

  accepts_nested_attributes_for :authentications
  has_many :cards, :authentications, dependent: :destroy

  validates :email, :password, :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, length: { minimum: 6 }, confirmation: true
end
