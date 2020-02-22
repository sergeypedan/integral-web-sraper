# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

desc "Creates a directory “db”, creates an SQLite3 database with a table and dumps structure into “schema.db”. Will not delete existing DB."

namespace :db do
  task :setup do
    require "active_record"
    require "pry"

    ActiveRecord::Base.logger = Logger.new(STDOUT)

    require_relative "../lib/integral/web_scraper/database_connection"

    CONNECTION = ActiveRecord::Base.connection

    # ActiveRecord::Base.connection.create_database("data")

    puts
    if CONNECTION.table_exists?(:pages)
      puts "Table :pages found -> doing nothing"
    else
      puts "Table :pages not found -> creating it right now"

      CONNECTION.create_table :pages do |t|
        t.string   :url,   null: false
        t.string   :title, null: false, default: ""
        t.datetime :downloaded_at
        t.datetime :processed_at
        t.text     :downloaded_html, null: false, default: ""
        t.text     :processed_html,  null: false, default: ""
        t.text     :ebook_html,      null: false, default: ""
      end

      CONNECTION.add_index :pages, :url, unique: true

    end

    puts "Dumping schema"
    dir = ENV["ENV"] == "test" ? "spec/db" : "db"
    File.open("#{dir}/schema.rb", "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(CONNECTION, file)
    end

  end
end
