# CardsHelper - list of helpers for Cards controller
# frozen_string_literal: true

module CardsHelper
  def format_date(date)
    date.strftime('%d/%m/%Y')
  end

  def today
    DateTime.now.to_date.to_s
  end

  def days_after(n)
    DateTime.now.next_day(n).to_date.to_s
  end
end
