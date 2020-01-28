# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Set active deck', type: :feature do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let(:locale) { create(:locale, user: user).locale }

  describe 'deck activation' do
    before do
      login_user(user, user_sessions_url)
      visit edit_dashboard_deck_path(deck)
      find(:css, '#deck_activity').set(true)
      click_button 'commit'
    end

    it 'creates deck in navigation' do
      expect(page).to have_selector '.nav-item--deck'
    end

    it 'renders link to current deck cards in menu' do
      looking_name = deck.name.capitalize
      expect(page).to have_link looking_name, href: dashboard_deck_cards_path(deck)
    end
  end
end
