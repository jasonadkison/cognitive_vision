module CognitiveVision
  class AnalyzeResponse
    attr_reader :adult, :categories, :faces

    def initialize(options = {})
      @adult      = options.fetch(:adult, nil)
      @categories = options.fetch(:categories, [])
      @faces      = options.fetch(:faces, [])
    end

    def self.parse(response_hash, features)
      options = features.analyzers.map do |analyzer|
                  [analyzer.key.to_sym, analyzer.parse(response_hash)]
                end.to_h
      new(options)
    end
  end
end
