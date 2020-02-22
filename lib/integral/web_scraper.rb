# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

require "integral/web_scraper/version"
# require "integral/web_scraper/database_connection"
require "integral/web_scraper/validate"
require "integral/web_scraper/models/page"

module Integral
  module WebScraper

    def self.load_tasks!
      require "pathname"
      require "rake"

      rake_dir = File.expand_path("../../rakelib", __dir__)
      pathname = Pathname.new(rake_dir)
      # puts %{Searching Rake files in dir: "#{pathname.realpath}"}

      rake_files = pathname.children.select(&:file?).select { |fn| fn.extname == ".rake" }.sort
      # puts %{#{rake_files.size} Rake files found in directory "#{rake_dir}":}
      rake_files.each { |f| ["•", f].join(" ") }

      return if rake_files.empty?

      # puts "Loading those Rake files…"
      rake_files.each { |f| load(f) }
      # puts "…loaded"
    end

    class Error < StandardError
    end

  end
end
