# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class CardSeed
  def initialize
    @dict = []
    scrap_card_data
    seed
  end

  def scrap_card_data
    url = 'http://1000mostcommonwords.com/1000-most-common-german-words/'
    doc = Nokogiri::HTML(open(url))

    selector = '.entry-content tr:nth-child(n+2) td:nth-child(n+2)'
    words = doc.css(selector)

    words.each_with_index do |link, i|
      break if i == 10

      orig_text = link.content
      tr_text = words[i + 1]

      next if tr_text.nil?

      dict_item = {}
      dict_item['original_text'] = orig_text
      dict_item['translated_text'] = tr_text.content
      dict_item['review_date'] = Date.today.to_time
      @dict.push(dict_item)
    end
  end

  def seed
    Card.import @dict
  end
end

CardSeed.new
