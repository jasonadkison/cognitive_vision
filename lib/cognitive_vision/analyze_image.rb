require 'json'
require 'net/http'

class AnalyzeImage
  def self.analyze_image(image_url)
    endpoint = 'https://api.projectoxford.ai/vision/v1.0/analyze'
    body = { 'url' => image_url }

    uri = URI(endpoint)
    uri.query = URI.encode_www_form('visualFeatures' => 'Faces')
    req = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
    req['Ocp-Apim-Subscription-Key'] = CognitiveVision.configuration.key
    req.body = body.to_json
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end

    AnalyzeResponse.parse(JSON.parse(response.body))
  end
end
