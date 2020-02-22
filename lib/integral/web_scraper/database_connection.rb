# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

require "active_record"

# ActiveRecord::Base.logger = Logger.new(STDOUT)

dir = ENV["ENV"] == "test" ? "spec/db" : "db"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "#{dir}/db.sqlite3")
