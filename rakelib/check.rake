# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

desc "Checks integrity of project"

task :check do

  transformer = PageTransformer.new("", "")

  [:html, :page_title].each do |method_name|
    abort "PageTransformer must have a method :#{method_name}" unless transformer.respond_to? method_name
  end

  ["epub.yml", "urls.yml"].each do |file_name|
    abort "A file “#{file_name}” must exist in the folder “config”" unless File.exist? File.expand_path(file_name, "config")
  end

  ["db.sqlite3", "schema.rb"].each do |file_name|
    abort "You need to run “rake db:setup” to setup the database" unless File.exist? File.expand_path(file_name, "db")
  end

  urls = YAML.load_file("config/urls.yml")
  abort "The file “urls.yml” must contain an Array at top level" unless urls.is_a? Array
  Integral::WebScraper::Validate.absolute!(urls)
  Integral::WebScraper::Validate.unique!(urls)

  puts "All correct"

end
