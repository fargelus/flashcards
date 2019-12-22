# General mailer class
# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Settings.gmail.login
  layout 'mailer'
end
