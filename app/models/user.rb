# User model
# frozen_string_literal: true

class User < ApplicationRecord
  has_many :cards, dependent: :destroy

  validates :email, :password, presence: true
  validates :email, uniqueness: true
end
