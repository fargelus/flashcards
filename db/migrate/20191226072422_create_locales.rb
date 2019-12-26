# frozen_string_literal: true

class CreateLocales < ActiveRecord::Migration[5.0]
  def change
    create_table :locales do |t|
      t.string :locale, default: I18n.default_locale
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
