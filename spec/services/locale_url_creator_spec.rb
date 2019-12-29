# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocaleUrlCreator, type: :service do
  describe '.call' do
    let(:default_locale) { I18n.default_locale.to_s }
    let(:other_locale) do
      app_locales = I18n.available_locales
      def_locale = I18n.default_locale
      app_locales.reject { |locale| locale == def_locale }[0]
    end
    let(:root_path) { '/' }

    it 'returns same url when locale default' do
      localized_url = LocaleUrlCreator.call(default_locale, root_path)
      expect(localized_url).to eql root_path
    end

    it 'returns locale dependent url when locale not default' do
      localized_url = LocaleUrlCreator.call(other_locale, root_path)
      expect(localized_url).to include other_locale.to_s
    end
  end
end
