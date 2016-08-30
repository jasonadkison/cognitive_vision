require 'json'
require 'net/http'

module CognitiveVision
  class AnalyzeImage
    def self.analyze_image(image_url)
      body     = { 'url' => image_url }
      params   = { 'visualFeatures' => 'Faces' }
      response = Connection.new.post('/analyze', params, body)

      AnalyzeResponse.parse(response.body)
    end
  end
end
