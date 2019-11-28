# frozen_string_literal: true

module ApplicationHelper
  def nav_link(href, text_content)
    str_href = (href[0] == '/' ? href[1..-1] : href).to_s
    page_url = request.fullpath[1..-1]
    current_page = str_href.eql? page_url
    classes = 'nav-link' + (current_page ? ' active' : '')

    link_to text_content, href, class: classes
  end
end
