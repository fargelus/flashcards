# frozen_string_literal: true

# Service for updating locale

class SetUserLocaleService < Callable
  def initialize(user, attrs = nil)
    @user = user
    @attrs = attrs
  end

  def call
    if @attrs
      @user.locale.update_attributes!(@attrs)
    else
      @user.create_locale
    end
  end
end
