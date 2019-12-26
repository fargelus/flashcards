# App locale model
# frozen_string_literal: true

class Locale < ApplicationRecord
  belongs_to :user

  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }
end
