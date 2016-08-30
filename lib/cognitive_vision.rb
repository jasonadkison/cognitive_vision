require 'cognitive_vision/version'
require 'cognitive_vision/configuration'
require 'cognitive_vision/face'
require 'cognitive_vision/analyze_response'
require 'cognitive_vision/analyze_image'

module CognitiveVision
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
