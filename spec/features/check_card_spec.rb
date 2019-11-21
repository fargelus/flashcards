# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Check card', type: :feature do
  let!(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }

  describe 'checking card process' do
    it 'checks card' do
      visit root_path
      fill_in 'answer', with: answer.answer
      click_button 'commit'
      expect(page).to have_selector '.notice'
    end
  end
end
