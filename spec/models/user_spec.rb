# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, activity: true, user: user) }
  let!(:card) { create(:card, deck: deck) }

  describe 'associations' do
    it { should have_many(:decks).dependent(:destroy) }
    it { should have_many(:authentications).dependent(:destroy) }
    it { should accept_nested_attributes_for(:authentications) }
    it { should have_one(:locale).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should allow_value('test@example.com').for(:email) }
    it { should validate_presence_of :password }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of :password_confirmation }
  end

  context 'methods' do
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

    describe '.with_review_cards' do
      it 'returns user with cards need to review' do
        users_with_cards = User.with_review_cards
        expect(users_with_cards).to include(user)
      end
    end

    describe '.notify_about_cards' do
      it 'delays sending email' do
        ActiveJob::Base.queue_adapter = :test
        expect { User.notify_about_cards }.to have_enqueued_job.on_queue('mailers')
      end
    end
  end
end
