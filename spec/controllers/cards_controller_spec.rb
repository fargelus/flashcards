# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'GET #index' do
    render_views

    it 'renders :index template' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'show a list of all cards' do
      total = Card.all.count
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
end
