require_relative 'lib/integral/web_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = "integral-web_scraper"
  spec.version       = Integral::WebScraper::VERSION
  spec.authors       = ["Sergey Pedan"]
  spec.email         = ["sergey.pedan@gmail.com"]

  spec.summary       = %q{Downloads web pages, transforms them and saves however you prefer}
  spec.description   = %q{Downloads a set of web pages from your URLs list, saves them into a local SQLite file and calls your transformer class to deal with them, saving the results into the DB. Can further export transformed HTML or create an ePub.}
  spec.homepage      = "https://github.com/sergeypedan/integral-web-scraper"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sergeypedan/integral-web-scraper/tree/master"
  spec.metadata["changelog_uri"] = "https://github.com/sergeypedan/integral-web-scraper/blob/master/Changelog.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", [">= 4"]
  spec.add_runtime_dependency "http", [">= 4.3"]
  spec.add_runtime_dependency "typhoeus", [">= 1.3.1"]
  spec.add_runtime_dependency "json", [">= 2.3"]
  spec.add_runtime_dependency "nokogiri", [">= 1.10"]
  spec.add_runtime_dependency "rake", [">= 13"]
  spec.add_runtime_dependency "sqlite3", [">= 1.4"]
end

