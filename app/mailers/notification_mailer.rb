# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def pending_cards
    User.with_review_cards.each do |user|
      @user = user
      mail(to: @user.email, subject: I18n.t(:pending_cards_email_subject))
    end
  end
end
