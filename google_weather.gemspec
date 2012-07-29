Gem::Specification.new do |s|
  s.name        = 'google_weather'
  s.version     = '0.0.1'
  s.date        = '2012-07-28'
  s.summary     = "Google Weather API"
  s.description = "A google weather API"
  s.authors     = ["Dan Ahern"]
  s.email       = 'me@danahern.com'
  s.files = %w(README.md Rakefile google_weather.gemspec)
  s.files += Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("spec/**/*")
  s.require_paths = ['lib']
  s.test_files = Dir.glob("spec/**/*")
  s.add_dependency "xml-simple"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end