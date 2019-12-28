# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Locale, type: :model do
  describe 'associations' do
    it { belong_to :user }
  end

  describe 'validations' do
    it { validate_inclusion_of(:locale).in_array(Locale.list) }
  end
end
