# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:user) { create(:user) }
  let(:test_card) { build(:card, user_id: user.id) }

  before(:each) { login_user(user) }

  describe 'GET #index' do
    render_views

    it 'redirects to login when not authorize' do
      logout_user
      get :index
      expect(response).to redirect_to login_path
    end

    it 'shows a list of all current_user cards' do
      total = user.cards.all.count
      get :index
      expect(response.body).to match total.to_s
    end
  end

  describe 'GET #new' do
    it 'renders :new template' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    subject (:post_card) do
      {
        card: {
          original_text: test_card.original_text,
          translated_text: test_card.translated_text,
          review_date: test_card.review_date
        }
      }
    end

    it 'creates new card' do
      expect { post :create, params: post_card }.to change { Card.count }.by(1)
    end
  end
end
