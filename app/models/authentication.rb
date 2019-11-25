# frozen_string_literal: true

class Authentication < ApplicationRecord
  # attr_accessible :user_id, :provider, :uid
  belongs_to :user
end
