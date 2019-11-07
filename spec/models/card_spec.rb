# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card) { FactoryBot.create(:card) }

  context 'check attributes' do
    it 'is valid with all attrs filled' do
      expect(card).to be_valid
    end

    it 'is not valid when original_text is null' do
      card.original_text = nil
      expect(card).to_not be_valid
    end

    it 'is not valid without translated_text' do
      card.translated_text = nil
      expect(card).to_not be_valid
    end

    it 'is not valid without review_date' do
      card.review_date = nil
      expect(card).to_not be_valid
    end

    describe 'validations' do
      it { should validate_uniqueness_of(:original_text) }
    end

    it 'is not valid when original_text eq translated_text' do
      card.original_text = card.translated_text
      expect(card).to_not be_valid
    end
  end

  context 'check scopes' do
    it '.random' do
      expect(Card.random.to_sql).to eq Card.order('RANDOM()').to_sql
    end

    it '.need_review' do
      expected = Card.where('review_date <= ?', Date.today).to_sql
      expect(Card.need_review.to_sql).to eq expected
    end
  end
end
