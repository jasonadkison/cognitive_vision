class AnalyzeResponse
  attr_reader :faces

  def initialize(options = {})
    @faces = options.fetch(:faces, [])
  end

  def self.parse(response_hash)
    faces = response_hash['faces'].map { |face| Face.new(gender: face['gender'], age: face['age']) }
    self.new(faces: faces)
  end
end
