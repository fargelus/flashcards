# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateUserService, type: :service do
  let!(:user) { create(:user) }
  let!(:locale) { create(:locale, user: user) }
  let!(:new_locale) { I18n.default_locale.to_s }
  let!(:password) { attributes_for(:user)[:password] }
  let!(:update_params) do
    {
      user: {
        email: user.email,
        password: password,
        password_confirmation: password
      },
      locale: new_locale
    }
  end
  let(:authentication) { create(:authentication, user: user) }

  describe '.call' do
    it 'updates user record' do
      result = UpdateUserService.call(user, update_params)
      expect(result).to be true
    end

    it 'updates user locale' do
      authentication
      UpdateUserService.call(user, update_params)
      expect(user.locale.locale).to eq new_locale
    end
  end
end
