# frozen_string_literal: true

require 'rails_helper'

describe 'Whenever Schedule' do
  let(:schedule) do
    Whenever::Test::Schedule.new(file: 'config/schedule.rb')
  end
  let(:jobs) { schedule.jobs[:runner] }

  it 'has User.notify_about_cards task' do
    tasks = jobs.pluck(:task)
    expect(tasks).to include 'User.notify_about_cards'
  end

  it 'performs User.notify_about_cards task every day' do
    job = jobs.find { |job| job[:task] == 'User.notify_about_cards' }
    duration = job[:every]
    expect(duration).to include 1.day
  end
end
