# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:deck) { create(:deck) }
  let!(:card) { create(:card, deck: deck) }

  describe 'associations' do
    it { should have_many(:answers) }
    it { should belong_to(:deck) }
  end

  context 'check attributes' do
    it 'is valid with all attrs filled' do
      expect(card).to be_valid
    end

    describe 'validations' do
      it { should validate_presence_of(:original_text) }
      it { should validate_presence_of(:translated_text) }
      it { should validate_presence_of(:review_date) }
      it { should validate_uniqueness_of(:original_text).scoped_to(:deck_id) }
    end

    it 'is not valid when original_text eq translated_text' do
      card.original_text = card.translated_text
      expect(card).to_not be_valid
    end
  end

  context 'check scopes' do
    it '.need_review' do
      earliest_date = Date.yesterday
      exist_card = Card.order(:review_date).first
      earliest_date = exist_card.review_date - 3 unless exist_card.blank?

      card.review_date = earliest_date
      card.save!
      expect(Card.need_review(deck.id)).to include card

      card.destroy
    end
  end
end
