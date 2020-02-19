desc "Fetch web pages and save them in the DB"

namespace :web_scraper do
  task :download_pages do
    require "integral/web_scraper/database_connection"

  	urls = YAML.load_file("config/urls.yml").sort
  	puts "#{urls.count} initially requested\n"

    puts "All URLs OK" if Validator.absolute_urls!(urls)

  	downloaded_pages = Page.select(:url).downloaded
  	puts "#{downloaded_pages.size} pages downloaded so far"

  	urls_not_in_cache = urls - downloaded_pages.map(&:url)
  	puts "#{urls_not_in_cache.size} to download"

  	urls_not_in_cache.each do |url|
      puts "Downloading #{url}"
      Page.create!(
      	downloaded_at: Time.current,
      	downloaded_html: HTTP.get(url).body.to_s,
      	url: url,
      )
    end

    puts "Now all pages are saved locally!"
  end
end
