$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "core"
  s.version     = Core::VERSION
  s.authors     = ["Buyant-Orgil"]
  s.email       = ["enkhbaatar_buyant-orgil@unimedia.co.jp"]
  s.homepage    = "http://www.unimedia.mn"
  s.summary     = "Marketing"
  s.description = "Marketing"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"
  s.add_dependency "devise"
  s.add_dependency "nobrainer"
  s.add_dependency "devise-nobrainer"
  s.add_dependency 'omniauth-facebook'
  s.add_dependency 'omniauth-twitter'
end
