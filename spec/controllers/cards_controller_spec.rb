# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  it 'renders index template' do
    get :index
    expect(response.status).to eq(200)
  end
end
