desc "Processes pages and saves resulting HTML into the DB"

namespace :web_scraper do
  task :process_epub_html do
    require "integral/web_scraper/database_connection"

    pages = Page.where(epub_html: "")
    puts "#{pages.size} to process\n"

    pages.each do |page|
      transformer = PageTransformer.new(page.downloaded_html, page.url)

      page_title     = transformer.page_title # cannot be called after `transformer.html`
      processed_html = transformer.html
      ebook_html     = Epub::Wrapper.new(content: processed_html, title: page_title).html

      page.update(processed_html: transformer.html, title: transformer.page_title)
    end

    puts "\nC'est fin!"

  end
end
