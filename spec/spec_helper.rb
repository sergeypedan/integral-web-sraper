abort "Use `ENV=test rspec` to trigger tests" unless ENV["ENV"] == "test"

require "bundler/setup"
require "integral/web_scraper"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "spec/db.sqlite3")

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
