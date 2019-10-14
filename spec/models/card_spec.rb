# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card, type: :model do
  subject do
    described_class.new(
      original_text: 'Hello, ruby world!',
      translated_text: 'Привет, руби!',
      review_date: '2019-10-13'
    )
  end

  it 'is valid with all attrs filled' do
    expect(subject).to be_valid
  end

  it 'is not valid without original_text is null' do
    subject.original_text = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without translated_text' do
    subject.translated_text = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without review_date' do
    subject.review_date = nil
    expect(subject).to_not be_valid
  end
end
