module CognitiveVision
  module ImageFeature
    class Adult
      def key
        'adult'
      end

      def parse(response)
        adult_response = response[key]
        CognitiveVision::Adult.new(adult_content: adult_response['isAdultContent'],
                                   adult_score: adult_response['adultScore'], racy_score: adult_response['racyScore'],
                                   racy_content: adult_response['isRacyContent'])
      end
    end
  end
end
