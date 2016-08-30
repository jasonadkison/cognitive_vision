require 'cognitive_vision/version'
require 'cognitive_vision/configuration'

module CognitiveVision
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
