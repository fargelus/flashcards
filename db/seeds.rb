# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

def fill_dict_from_page(dict)
  url = 'http://1000mostcommonwords.com/1000-most-common-german-words/'
  doc = Nokogiri::HTML(open(url))

  selector = '.entry-content tr:nth-child(n+2) td:nth-child(n+2)'
  words = doc.css(selector)

  words.each_with_index do |link, i|
    orig_text = link.content
    tr_text = words[i + 1]

    unless tr_text.nil?
      dict_item = Hash.new
      dict_item['original_text'] = orig_text
      dict_item['translated_text'] = tr_text.content
      dict.push(dict_item)
    end
  end

  dict
end

def fill_db_data_from_dict(dict)
  Card.import dict
end

dict = []
fill_dict_from_page(dict)
fill_db_data_from_dict(dict)
