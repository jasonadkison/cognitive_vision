module CognitiveVision
  module ImageFeature
    class Tag
      def key
        'tags'
      end

      def parse(response)
        response[key].map { |tag| CognitiveVision::Tag.new(name: tag['name'], confidence: tag['confidence']) }
      end
    end
  end
end
