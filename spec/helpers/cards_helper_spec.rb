# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsHelper, type: :helper do
  describe '#format_date' do
    it 'returns formatted date' do
      dt = DateTime.new(2019, 7, 24)
      expect(helper.format_date(dt)).to eq('24/07/2019')
    end
  end

  describe '#today' do
    it 'returns current date' do
      actual = helper.today

      now = helper.format_date(DateTime.now)
      actual = helper.format_date(actual)

      expect(actual).to eq(now)
    end
  end

  describe '#days_after' do
    it 'return some days after today' do
      five_days_later = (Date.today + 5).to_s
      expect(helper.days_after(5)).to eq(five_days_later)
    end
  end
end
