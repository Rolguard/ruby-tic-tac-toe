class Player
  # Create getters and setters for shape, number_id
  attr_accessor(:shape, :number_id)

  def initialize(number_id, shape)
    @number_id = number_id
    @shape = shape
  end
end