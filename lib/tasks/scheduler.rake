# frozen_string_literal: true

desc 'This task is called by the Heroku scheduler add-on'
task notify_about_cards: :environment do
  User.notify_about_cards
end
