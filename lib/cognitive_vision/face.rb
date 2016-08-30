class Face
  attr_reader :age, :gender

  def initialize(options = {})
    @age    = options.fetch(:age)
    @gender = options.fetch(:gender)
  end
end
