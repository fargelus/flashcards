# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Check card', type: :feature do
  let!(:user) { create(:user) }
  let!(:card) { create(:card, user_id: user.id) }
  let(:answer) { create(:answer, card_id: card.id) }

  describe 'checking card process' do
    before(:each) { login_user(user, user_sessions_url) }

    it 'checks card' do
      visit root_path
      fill_in 'answer', with: answer.answer
      click_button 'commit'
      expect(page).to have_selector '.notice'
    end
  end
end
