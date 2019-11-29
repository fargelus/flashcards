# frozen_string_literal: true

require 'rails_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  let(:card) { create(:card) }
  let(:uploader) { ImageUploader.new(card, :image) }

  before do
    ImageUploader.enable_processing = true
    File.open(Rails.root.join('spec/support/tree.png')) do |f|
      uploader.store!(f)
    end
  end

  after do
    ImageUploader.enable_processing = false
    uploader.remove!
  end

  context 'thumb version' do
    it 'scales down thumb img to be 30px' do
      expect(uploader.thumb).to have_dimensions(30, 30)
    end
  end

  context 'default version' do
    it 'sizes no more than 360px' do
      expect(uploader).to be_no_larger_than(360, 360)
    end

    it 'has right permissions' do
      expect(uploader).to have_permissions(0o644)
    end

    it 'has correct format' do
      expect(uploader).to be_format('png')
    end
  end
end
