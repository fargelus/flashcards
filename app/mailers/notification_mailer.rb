# Mailer for all system notifacations
# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def pending_cards(email)
    mail(to: email, subject: I18n.t(:pending_cards_email_subject))
  end
end
