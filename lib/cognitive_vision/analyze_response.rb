module CognitiveVision
  class AnalyzeResponse
    attr_reader :adult, :faces

    def initialize(options = {})
      @adult = options.fetch(:adult, {})
      @faces = options.fetch(:faces, [])
    end

    def self.parse(response_hash)
      faces = (response_hash['faces'] || []).map { |face| Face.new(gender: face['gender'], age: face['age']) }
      adult = if response_hash['adult']
                adult_response = response_hash['adult']
                Adult.new(adult_content: adult_response['isAdultContent'],
                          racy_content: adult_response['isRacyContent'], adult_score: adult_response['adultScore'],
                          racy_score: adult_response['racyScore'])
              end
      new(faces: faces, adult: adult)
    end
  end
end
