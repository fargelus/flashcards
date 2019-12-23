# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  describe '.pending_cards' do
    let(:user) { create(:user) }
    let(:mail) { NotificationMailer.pending_cards(user.email) }

    it 'has correct subject' do
      expect(mail.subject).to eql I18n.t(:pending_cards_email_subject)
    end

    it 'has correct mail receiver' do
      expect(mail.to).to include user.email
    end

    it 'has correct mail sender' do
      expect(mail.from).to include Settings.gmail.login
    end
  end
end
