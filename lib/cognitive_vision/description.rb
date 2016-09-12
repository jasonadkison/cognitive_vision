module CognitiveVision
  class Description
    attr_reader :captions, :tags

    def initialize(options = {})
      @captions = options.fetch(:captions, [])
      @tags     = options.fetch(:tags, [])
    end
  end
end
