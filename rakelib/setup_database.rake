desc "Fetch web pages and save them in the DB"

namespace :web_scraper do
  task :setup_database do
    require "active_record"

    ActiveRecord::Base.logger = Logger.new(STDOUT)

    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "db/db.sqlite3")

    CONNECTION = ActiveRecord::Base.connection

    # ActiveRecord::Base.connection.create_database("data")

    unless CONNECTION.table_exists?(:pages)

      puts "Table :pages not found -> creating it right now"

      CONNECTION.create_table :pages do |t|
        t.string   :url, null: false
        t.string   :title
        t.text     :downloaded_html
        t.datetime :downloaded_at
        t.text     :processed_html
        t.datetime :processed_at
      end

      File.open("db/schema.rb", "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(CONNECTION, file)
      end

    end

  end
end
