$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "console/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "console"
  s.version     = Console::VERSION
  s.authors     = ["Buyant-Orgil"]
  s.email       = ["enkhbaatar_buyant-orgil@unimedia.co.jp"]
  s.homepage    = "http://www.unimedia.mn"
  s.summary     = "Marketing"
  s.description = "Marketing"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"

  s.add_development_dependency "sqlite3"
end
