# CardsHelper - list of helpers for Cards controller
# frozen_string_literal: true

module CardsHelper
  def format_date(date)
    date.strftime('%d/%m/%Y %k:%M')
  end

  def today
    Date.today.to_s
  end

  def hours_after(hours)
    hours.hour.since
  end
end
