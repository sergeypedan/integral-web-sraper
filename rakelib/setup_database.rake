desc "Creates a directory \"db\", creates an SQLite3 database with a table and dumps structure into \"schema.db\". Will not delete existing DB."

namespace :web_scraper do
  task :setup_database do
    require "active_record"

    ActiveRecord::Base.logger = Logger.new(STDOUT)

    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "db/db.sqlite3")

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

      File.open("db/schema.rb", "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(CONNECTION, file)
      end

    end

  end
end
