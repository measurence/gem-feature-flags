$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "feature_flags/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "feature_flags"
  s.version     = FeatureFlags::VERSION
  s.authors     = ["Federico Feroldi"]
  s.email       = ["fferoldi@measurence.com"]
  s.homepage    = "http://github.com/measurence/gem-feature-flags"
  s.summary     = "A simple, opinionated rails plugin that adds feature flags to a user model."
  s.description = "A simple, opinionated rails plugin that adds feature flags to a user model."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
