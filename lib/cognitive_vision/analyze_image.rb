require 'json'
require 'net/http'

module CognitiveVision
  class AnalyzeImage
    class InvalidImageUrlError < StandardError; end

    def self.analyze_image(image_url)
      body     = { 'url' => image_url }
      params   = { 'visualFeatures' => 'Faces' }
      response = Connection.new.post('/analyze', params, body)

      raise InvalidImageUrlError if response.code != 200
      AnalyzeResponse.parse(response.body)
    end
  end
end
