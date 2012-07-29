require 'rubygems'
require 'bundler/setup'
require 'webmock'
require 'vcr'
require 'xmlsimple'

require 'google_weather'

RSpec.configure do |config|
  # some (optional) config here
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
end