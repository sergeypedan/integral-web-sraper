desc "Fetch web pages and save them in the DB"

task :download_pages do
  require "integral/web_scraper/database_connection"

  urls = YAML.load_file("config/urls.yml").uniq
  puts "#{urls.count} initially requested\n"

  Integral::WebScraper::Validate.absolute_urls!(urls)

  downloaded_pages = Integral::WebScraper::Page.select(:url).downloaded
  puts "#{downloaded_pages.count} pages downloaded so far"

  urls_not_in_cache = urls - downloaded_pages.map(&:url)
  puts "#{urls_not_in_cache.size} to download"

  exit 0 if urls_not_in_cache.empty?

  puts "Saving URLs into \"pages\" table"
  urls_not_in_cache.each do |url|
    Integral::WebScraper::Page.create!(url: url)
  end

  Integral::WebScraper::Page.not_downloaded.each do |page|
    puts "Downloading #{page.url}"
    html = HTTP.get(page.url).body.to_s
    Integral::WebScraper::Page.create!(downloaded_at: Time.current, downloaded_html: html)
  end

  puts "Now all pages are saved locally!"
end
