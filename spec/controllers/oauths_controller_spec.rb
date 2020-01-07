# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Welcome::OauthsController, type: :controller do
  describe 'GET #oauth' do
    let(:provider) { 'github' }

    it 'redirects to provider' do
      get :oauth, params: { provider: provider }
      expect(response.location).to match(provider)
    end
  end
end
