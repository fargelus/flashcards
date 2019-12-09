# CardsHelper - list of helpers for Cards controller
# frozen_string_literal: true

module CardsHelper
  def format_date(date)
    date.strftime('%d/%m/%Y')
  end

  def today
    Date.today.to_time
  end

  def days_after(days)
    Date.today.next_day(days).to_s
  end

  def hours_after(hours)
    hours.hour.since
  end
end
