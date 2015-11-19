$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_markdown/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_markdown"
  s.version     = RailsMarkdown::VERSION
  s.authors     = ["Matthew Clifford-Smith"]
  s.email       = ["dark.arc@gmail.com"]
  s.summary     = "Markdown in Rails views"
  s.description = "Allows for easy use of markdown in Rails views. And allows for some additional features"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "redcarpet", "~> 3.3"

  s.add_development_dependency "sqlite3"
end
