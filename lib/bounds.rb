class Bounds
  include Enumerable

  def initialize(min, max)
    @min = min
    @max = max
  end

  def position(x_dir = 0, y_dir = 0, from: nil)
    pos = (from || @min).step(x_dir, y_dir)
    yield(pos) if contains?(pos)
  end

  def out?(pos)
    pos.left_of?(@min) || pos.below?(@min) || pos.right_of?(@max) || pos.above?(@max)
  end

  def contains?(pos)
    !out?(pos)
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

  def move(x_dir, y_dir)
    self.class.new(@min.step(x_dir, y_dir), @max.step(x_dir, y_dir))
  end

  def sample
    to_a.sample
  end
end
