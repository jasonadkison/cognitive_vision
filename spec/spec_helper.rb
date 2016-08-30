$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'cognitive_vision'
require 'dotenv'
require 'pry'
require 'vcr'

Dotenv.load

CognitiveVision.configure do |config|
  config.key = ENV['VISION_API_KEY']
end

VCR.configure do |c|
  c.filter_sensitive_data('<API_KEY>') { CognitiveVision.configuration.key }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
