module CognitiveVision
  class Category
    attr_reader :name, :score

    def initialize(options = {})
      @name   = options.fetch(:name)
      @score  = options.fetch(:score)
    end
  end
end
