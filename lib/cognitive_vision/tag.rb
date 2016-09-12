module CognitiveVision
  class Tag
    attr_reader :confidence, :name

    def initialize(options = {})
      @confidence = options.fetch(:confidence)
      @name       = options.fetch(:name)
    end
  end
end
