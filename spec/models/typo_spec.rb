# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Typo, type: :model do
  describe 'associations' do
    it { should belong_to(:answer) }
  end
end
