# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dashboard::DecksController, type: :controller do
  let(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  before { login_user(user) }

  describe 'GET #index' do
    before { get :index }

    it 'has index page' do
      expect(response).to have_http_status(:success)
    end

    it 'has all decks' do
      expect(assigns(:decks)).to eq([deck])
    end
  end

  describe 'GET #new' do
    it 'has new page' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: deck.id } }

    it 'has edit page' do
      expect(response).to have_http_status(:success)
    end

    it 'fetch deck for edit' do
      expect(assigns(:deck)).to eq(deck)
    end
  end

  describe 'POST #create' do
    subject (:post_deck) do
      {
        deck: {
          name: deck.name.reverse,
          description: deck.description,
          activity: deck.activity
        }
      }
    end

    it 'creates new deck' do
      expect { post :create, params: post_deck }.to change { Deck.count }.by(1)
    end

    it 'redirects to decks_path' do
      post :create, params: post_deck
      expect(response).to redirect_to dashboard_decks_path
    end

    it 'shows notice after create' do
      post :create, params: post_deck
      expect(flash[:notice]).to eq I18n.t(:deck_created)
    end

    it 'renders new template when deck params bad' do
      post_deck[:deck][:name] = nil
      post :create, params: post_deck
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #destroy' do
    subject (:delete_deck) { { id: deck.id } }

    it 'destroys deck' do
      expect { delete :destroy, params: delete_deck }.to change { Deck.count }.by(-1)
    end
  end

  describe 'PATCH #update' do
    subject(:deck_name) { deck.name.reverse }
    subject(:updated_deck) do
      {
        id: deck.id,
        deck: {
          name: deck_name,
          description: 'Useful description',
          activity: true
        }
      }
    end

    it 'patches current deck name' do
      patch :update, params: updated_deck
      saved_deck = Deck.find(deck.id)
      expect(saved_deck.name).to eq(deck_name)
    end

    it 'renders edit template when update params bad' do
      updated_deck[:deck][:name] = nil
      patch :update, params: updated_deck
      expect(response).to render_template(:edit)
    end
  end
end
