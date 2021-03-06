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

  def active_deck(user)
    User.active_deck(user)
  end

  def locale_link(locale, classes)
    sym_locale = locale.to_sym
    is_default_locale = I18n.default_locale == locale
    path = is_default_locale ? request.path : url_for(locale: locale)
    link_to I18n.t(sym_locale), path, class: classes
  end

  def root_page?
    current_page?(root_path) || current_page?(dashboard_root_path)
  end

  def root_page(user)
    return dashboard_root_path if user

    root_path
  end
end
