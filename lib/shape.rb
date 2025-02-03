class Shape
  # Each shape should be able to get shape value and modify shape value
  def initialize(shape)
    @shape = shape
  end

  def value
    @shape
  end
  
  def value=(new_shape)
    @shape = new_shape
  end
  
end