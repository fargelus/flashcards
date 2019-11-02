# Model for answers
# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :phrase, :answer, presence: true
end
