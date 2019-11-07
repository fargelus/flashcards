# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  let (:card) { FactoryBot.create(:card) }
  let (:answer) { FactoryBot.create(:answer, card_id: card.id) }

  it 'is not valid when phrase nil' do
    answer.phrase = nil
    expect(answer).to_not be_valid
  end

  it 'is not valid when answer nil' do
    answer.answer = nil
    expect(answer).to_not be_valid
  end

  it 'is not without card_id' do
    answer.card_id = nil
    expect(answer).to_not be_valid
  end
end
