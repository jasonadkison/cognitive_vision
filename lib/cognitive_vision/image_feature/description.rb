module CognitiveVision
  module ImageFeature
    class Description
      def key
        'description'
      end

      def parse(response)
        description_response = response[key]
        captions = description_response['captions'].map do |caption|
          CognitiveVision::DescriptionCaption.new(text: caption['text'], confidence: caption['confidence'])
        end
        CognitiveVision::Description.new(tags: description_response['tags'], captions: captions)
      end
    end
  end
end
