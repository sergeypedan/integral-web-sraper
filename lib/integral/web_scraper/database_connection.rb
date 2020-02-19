# frozen_string_literal: true

require "active_record"

# ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "db/db.sqlite3")
