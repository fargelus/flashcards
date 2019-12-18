# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAnswerCreator, type: :service do
  let!(:card) { create(:card) }
  let!(:answer) { UserAnswerCreator.call(card) }

  describe '.call' do
    it 'returns answer in any case' do
      expect(answer).to be
    end
  end
end
