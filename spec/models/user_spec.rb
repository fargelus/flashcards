# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'associations' do
    it { should have_many(:cards) }
    it { should have_many(:authentications) }
    it { should accept_nested_attributes_for(:authentications) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should allow_value('test@example.com').for(:email) }
    it { should validate_presence_of :password }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of :password_confirmation }
  end
end
