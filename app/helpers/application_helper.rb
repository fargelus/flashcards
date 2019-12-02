# frozen_string_literal: true

module ApplicationHelper
  def nav_link(href, text_content)
    link_url = href.to_s
    skip_first_char = ->(str) { str[1..-1] }
    link_url = skip_first_char.call(link_url) if link_url[0] == '/'

    page_url = request.fullpath[1..-1]
    current_page = page_url.eql? link_url
    classes = 'nav-link' + (current_page ? ' active' : '')

    link_to text_content, href, class: classes
  end

  def cards?(user)
    decks = user.decks
    decks.any? { |deck| deck.cards.count.positive? }
  end

  def current_deck
    Deck.find_by_activity(true)
  end
end
