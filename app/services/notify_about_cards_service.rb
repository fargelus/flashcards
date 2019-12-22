# frozen_string_literal: true

# Service that sends notification to users about cards waiting to review

class NotifyAboutCardsService < Callable
  def call
    User.with_review_cards.each do |user|
      NotificationMailer.pending_cards(user.email).deliver_later
    end
  end
end
