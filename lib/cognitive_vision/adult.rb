module CognitiveVision
  class Adult
    attr_reader :adult_score, :racy_score

    def initialize(options = {})
      @adult_content = options.fetch(:adult_content)
      @adult_score   = options.fetch(:adult_score)
      @racy_content  = options.fetch(:racy_content)
      @racy_score    = options.fetch(:racy_score)
    end

    def adult_content?
      @adult_content
    end

    def racy_content?
      @racy_content
    end
  end
end
