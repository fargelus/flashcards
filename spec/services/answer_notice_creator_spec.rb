# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerNoticeCreator, type: :service do
  let(:card) { create(:card) }
  let(:answer) { create(:answer, card_id: card.id) }

  describe '.call' do
    it 'no need for notice after call' do
      AnswerNoticeCreator.call(answer)
      expect(answer.need_notice).to be_falsey
    end
  end
end
