# Model for user typos which appear when he guessing the card
# frozen_string_literal: true

class Typo < ApplicationRecord
  belongs_to :answer
end
