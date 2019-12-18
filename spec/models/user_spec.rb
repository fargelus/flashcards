# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, activity: true, user: user) }

  describe 'associations' do
    it { should have_many(:decks) }
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

  describe '.active_deck' do
    let(:active_deck) { User.active_deck(user) }
    let!(:other_deck) do
      create(
        :deck,
        name: 'Abc',
        activity: true,
        user: user
      )
    end

    it 'has active deck' do
      expect(active_deck).to be
    end

    it 'has only one active deck' do
      expect(active_deck).to be_an_instance_of(Deck)
    end
  end

  describe '.all_decks_id' do
    it 'returns ids of all decks' do
      ids = User.all_decks_id(user)
      expect(ids.size).to eql user.decks.count
    end
  end
end
