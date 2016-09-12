module CognitiveVision
  module ImageFeature
    class Face
      def key
        'faces'
      end

      def parse(response)
        response[key].map { |face| CognitiveVision::Face.new(gender: face['gender'], age: face['age']) }
      end
    end
  end
end
