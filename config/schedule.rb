# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.

set :environment, 'development'
set :output, error: 'log/cron_error_log.log', standard: 'log/cron_log.log'
env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

every 1.day do
  runner 'User.notify_about_cards'
end
