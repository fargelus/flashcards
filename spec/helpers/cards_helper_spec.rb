# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsHelper, type: :helper do
  describe '#format_date' do
    it 'returns formatted date' do
      dt = DateTime.new(2019, 7, 24)
      expect(helper.format_date(dt)).to eq('24/07/2019  0:00')
    end
  end

  describe '#today' do
    it 'returns current date' do
      actual = helper.today
      now = DateTime.now.to_date.to_s
      expect(actual).to eq(now)
    end
  end

  describe '#hours_after' do
    it 'returns hours since now' do
      tomorrow = Date.today.next_day
      checkable = hours_after(24).to_date
      expect(checkable).to eq(tomorrow)
    end
  end
end
