# Seed for locales table
# frozen_string_literal: true

class LocaleSeed
  def initialize
    @users = User.all
    @dict = []
    seed
  end

  private

  def seed
    fill_locale_data
    Locale.import @dict
  end

  def fill_locale_data
    user_ids = @users.collect(&:id)
    user_ids.each do |id|
      @dict.push ({
        locale: I18n.default_locale,
        user_id: id,
      })
    end
  end
end

LocaleSeed.new
