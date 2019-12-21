# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.

every 1.day do
  runner 'User.notify_about_cards'
end
