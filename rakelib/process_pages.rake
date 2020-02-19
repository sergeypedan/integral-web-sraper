desc "Process pages’ HTML and save the resulting HTML in the DB"

namespace :web_scraper do
  task :process_pages do
    require "integral/web_scraper/database_connection"

  	pages = Integral::WebScraper::Page.where(processed_html: nil)
    puts "#{pages.size} to process\n"

    pages.each do |page|
      transformer = PageTransformer.new(page.downloaded_html, page.url)
      page.update(processed_html: transformer.html, title: transformer.page_title)
    end

    puts "\nC'est fin!"

  end
end
