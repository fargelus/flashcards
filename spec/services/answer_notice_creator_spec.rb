# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerNoticeCreator, type: :service do
  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }
  let(:flash) { ActionDispatch::Flash::FlashHash.new }

  describe '.call' do
    it 'shows notice when called' do
      AnswerNoticeCreator.call(answer, flash)
      expect(flash[:notice]).to be
    end
  end
end
