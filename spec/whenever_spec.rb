require 'spec_helper'

describe 'Whenever Schedule' do
  it 'makes sure `runner` statements exist' do
    schedule = Whenever::Test::Schedule.new(file: 'config/schedule.rb')
    expect(schedule.jobs[:runner].count).to be eql 1
  end
end
