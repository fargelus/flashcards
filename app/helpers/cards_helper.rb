# CardsHelper - list of helpers for Cards controller
# frozen_string_literal: true

module CardsHelper
  def format_date(date)
    date.strftime('%d/%m/%Y')
  end
end
