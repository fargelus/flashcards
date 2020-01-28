# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Welcome::HomeController, type: :controller do
  describe 'GET #home' do
    it 'renders :index template' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
