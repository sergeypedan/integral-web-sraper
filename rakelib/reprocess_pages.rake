desc "Re-processes all pages’ HTML and save results in the DB"

task :reprocess_pages do
  require "integral/web_scraper/database_connection"

  pages = Integral::WebScraper::Page.all
  puts "#{pages.size} to re-process\n"

  pages.each do |page|
    transformer = PageTransformer.new(page.downloaded_html, page.url)
    page.update(processed_html: transformer.html, title: transformer.page_title, processed_at: Time.current)
  end

  puts "\nC'est fin!"

end
