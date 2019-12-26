# frozen_string_literal: true

# Determine client's preferred locale

class BrowserLocaleService < Callable
  def initialize(locales)
    @app_locales = locales
  end

  def call
    http_accept_language.compatible_language_from(@app_locales)
  end
end
