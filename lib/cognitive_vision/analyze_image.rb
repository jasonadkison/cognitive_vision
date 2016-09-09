require 'json'
require 'net/http'

module CognitiveVision
  class AnalyzeImage
    class InvalidImageSizeError < StandardError; end
    class InvalidImageUrlError  < StandardError; end
    class UnknownError          < StandardError; end

    def self.analyze_image(image_url, types = [:faces])
      types    = [types] unless types.is_a?(Array)
      body     = { 'url' => image_url }
      params   = { 'visualFeatures' => types.join(',') }
      response = Connection.new.post('/analyze', params, body)

      treat_errors(response) if response.code != 200
      AnalyzeResponse.parse(response.body)
    end

    def self.treat_errors(response)
      case response.body['code']
      when 'InvalidImageSize'
        raise(InvalidImageSizeError, response.body['message'])
      when 'InvalidImageUrl'
        raise(InvalidImageUrlError, response.body['message'])
      else
        raise(UnknownError, response.body['message'])
      end
    end
  end
end
