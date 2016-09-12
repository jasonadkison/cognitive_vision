module CognitiveVision
  class ImageFeatures
    ANALYZERS = {
      adult:      ImageFeature::Adult.new,
      categories: ImageFeature::Category.new,
      faces:      ImageFeature::Face.new
    }

    def initialize(features)
      @features = [features].flatten
    end

    def features_string
      @features.join(',')
    end

    def analyzers
      ANALYZERS.map{ |feature, analyzer| analyzer if @features.include?(feature) }.reject(&:nil?)
    end
  end
end
