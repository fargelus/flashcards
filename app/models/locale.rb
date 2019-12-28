# App locale model
# frozen_string_literal: true

class Locale < ApplicationRecord
  belongs_to :user

  def self.list
    I18n.available_locales.map(&:to_s)
  end

  validates :locale, inclusion: { in: list }
end
