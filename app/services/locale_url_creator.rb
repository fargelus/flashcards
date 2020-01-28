# frozen_string_literal: true

# Service for building right locale dependent url

class LocaleUrlCreator < Callable
  def initialize(locale, path)
    @locale = locale
    @path = path
  end

  def call
    @locale == I18n.default_locale.to_s ?
               url_without_params :
               queried_url
  end

  private

  def url_without_params
    uri = URI @path
    params = Rack::Utils.parse_query uri.query
    params.delete 'locale'
    uri.query = params.to_param.blank? ? nil : params.to_param
    uri.to_s
  end

  def queried_url
    @path + '?' + { locale: @locale }.to_query
  end
end
