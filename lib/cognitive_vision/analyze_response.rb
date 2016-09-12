module CognitiveVision
  class AnalyzeResponse
    attr_reader :adult, :categories, :description, :faces, :tags

    def initialize(options = {})
      @adult       = options.fetch(:adult, nil)
      @categories  = options.fetch(:categories, [])
      @description = options.fetch(:description, nil)
      @faces       = options.fetch(:faces, [])
      @tags        = options.fetch(:tags, [])
    end

    def self.parse(response_hash, features)
      parsed = features.analyzers.map do |analyzer|
                 [analyzer.key.to_sym, analyzer.parse(response_hash)]
               end
      new(Hash[parsed])
    end
  end
end
