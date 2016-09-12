module CognitiveVision
  class DescriptionCaption
    attr_reader :confidence, :text

    def initialize(options = {})
      @confidence = options.fetch(:confidence)
      @text       = options.fetch(:text)
    end
  end
end
