require 'net/http'
require 'uri'

module CognitiveVision
  class Connection
    ENDPOINT = 'https://api.projectoxford.ai/vision/v1.0/'.freeze

    def initialize
      @uri          = URI(ENDPOINT)
      @http         = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = @uri.scheme == 'https'
    end

    def post(path, params, body)
      uri = prepare_uri(path, params)
      request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
      request['Ocp-Apim-Subscription-Key'] = CognitiveVision.configuration.key
      request.body = body.to_json
      request_json(request)
    end

    private

    def prepare_uri(path, query_params)
      uri       = @uri.dup
      uri.path += path
      uri.query = URI.encode_www_form(query_params)
      uri
    end

    def request_json(request)
      response = @http.request(request)
      body     = JSON.parse(response.body)

      raise RateLimitError if response.code.to_i == 429
      OpenStruct.new(code: response.code.to_i, body: body)
    end
  end
end
