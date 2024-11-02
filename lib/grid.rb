class Grid
  include Enumerable

  def initialize(min, max)
    @min = min
    @max = max
  end

  def step(x_dir = 0, y_dir = 0, from: nil)
    from ||= @min
    pos = from.step(x_dir, y_dir)
    yield(pos) if in_bounds?(pos)
  end

  def out_of_bounds?(pos)
    pos.left_of?(@min) || pos.below?(@min) || pos.right_of?(@max) || pos.above?(@max)
  end

  def in_bounds?(pos)
    !out_of_bounds?(pos)
  end

  def each
    return to_enum(:each) unless block_given?

    position = @min
    until position.above?(@max) do
      row_position = position
      until row_position.right_of?(@max) do
        yield(row_position)
        row_position = row_position.right
      end
      position = position.up
    end
  end

  def sample
    to_a.sample
  end
end
