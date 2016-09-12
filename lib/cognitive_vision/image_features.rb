module CognitiveVision
  class ImageFeatures
    def initialize(features)
      @features = [features].flatten
    end

    def features_string
      @features.join(',')
    end
  end
end
