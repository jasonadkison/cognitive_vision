$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
require 'codeclimate-test-reporter'
SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ])
end
CodeClimate::TestReporter.start

require 'cognitive_vision'
require 'dotenv'
require 'pry'
require 'vcr'
require 'webmock/rspec'

Dotenv.load

CognitiveVision.configure do |config|
  config.key = ENV['VISION_API_KEY']
end

VCR.configure do |c|
  c.filter_sensitive_data('<API_KEY>') { CognitiveVision.configuration.key }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_hosts 'codeclimate.com'
end

# whitelist codeclimate.com so test coverage can be reported
RSpec.configure do |config|
  config.after(:suite) do
    WebMock.disable_net_connect!(allow: 'codeclimate.com')
  end
end
