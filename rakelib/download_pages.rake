# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

desc "Fetch web pages and save them in the DB"

task :download_pages do
  require "httparty"
  require_relative "../lib/integral/web_scraper/database_connection"

  yaml_urls = YAML.load_file("config/urls.yml")
  puts "#{yaml_urls.count} URLs initially requested\n"

  print "Checking URLs..."
  Integral::WebScraper::Validate.absolute!(yaml_urls)
  Integral::WebScraper::Validate.unique!(yaml_urls)
  puts "all look fine"

  puts

  print "Saving URLs into “pages” table..."
  # pages_urls = Integral::WebScraper::Page.select(:url)
  # yaml_urls - Integral::WebScraper::Page.pluck(:url)
  yaml_urls.each do |url|
    Integral::WebScraper::Page.create(url: url)
  end
  puts "done"

  puts

  downloaded_pages = Integral::WebScraper::Page.downloaded
  print "#{downloaded_pages.count} pages downloaded so far, "

  not_downloaded_pages = Integral::WebScraper::Page.not_downloaded
  puts "#{not_downloaded_pages.count} to download"

  abort "Not all URLs have been saved to Page records" if yaml_urls.size > Integral::WebScraper::Page.count
  if (downloaded_pages.count + not_downloaded_pages.count) < yaml_urls.size
    puts "We have an error in calculations: downloaded + not_downloaded not sum up to `yaml_urls.count`"
    puts "yaml_urls.count: #{yaml_urls.count}"
    puts "downloaded_pages.count: #{downloaded_pages.count}"
    puts "not_downloaded_pages.count: #{not_downloaded_pages.count}"
    exit 1
  end

  puts "All pages are saved locally!" and exit(0) if not_downloaded_pages.count.zero?

  puts

  puts "Downloading pages’ original HTML content"
  headers = {
    "Accept"          => "text/html,application/xhtml+xml,application/xml",
    "Accept-Charset"  => "utf-8",
    "Accept-Encoding" => "deflate",
    "Accept-Language" => "en-US,en;q=0.9,ru;q=0.8",
    "Cache-Control"   => "no-cache",
    "User-Agent"      => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36"
  }

  not_downloaded_pages.each do |page|
    puts "Downloading #{page.url}"
    html = HTTParty.get(page.url, headers: headers).body
    html = html.encode("UTF-8", html.encoding) if (html.encoding != Encoding::UTF_8)
    page.update(downloaded_at: Time.current, downloaded_html: html)
  end

  puts "All pages are saved locally!"
end
