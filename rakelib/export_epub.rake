# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

desc "Builds an ePub"

task "export_epub" do
  require "integral/web_scraper/database_connection"
  require_relative "../lib/processor"

  Epub::Opf.new.build_and_write!
  Epub::Saver.create_epub!
end

def self.create_pages!
  Book::PAGE_URLS.each_with_index do |url, index|
    html         = cached_or_new_html(url, index)
    transformer  = PageTransformer.new(html, url)
    page_title   = transformer.page_title # cannot be called after `transformer.html`
    content_html = transformer.html
    ebook_html   = Ebook::Wrapper.new(content: content_html, title: page_title).html
    Saver.save_epub_page!(ebook_html, index)
  end
end
