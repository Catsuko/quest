class Position
  class << self
    def at(x, y)
      new(translate(x), translate(y))
    end

    def translate(coord)
      ((coord / @scale).floor * @scale) + @scale_offset
    end

    def scale(n)
      n * (@scale)
    end

    def scale=(n)
      @scale_offset = (n * 0.5).floor
      @scale = n
    end
  end

  def initialize(x, y)
    @x = x
    @y = y
  end

  private_class_method :new, :translate

  def step(x_dir = 0, y_dir = 0)
    self.class.at(@x + self.class.scale(x_dir.floor), @y + self.class.scale(y_dir.floor))
  end

  def right(steps = 1)
    step(steps, 0)
  end

  def left(steps = 1)
    step(-steps, 0)
  end

  def up(steps = 1)
    step(0, steps)
  end

  def down(steps = 1)
    step(0, -steps)
  end

  def right_of?(other = nil, x: nil)
    return other.left_of?(x: @x) if other

    @x > x
  end

  def left_of?(other = nil, x: nil)
    return other.right_of?(x: @x) if other

    @x < x
  end

  def above?(other = nil, y: nil)
    return other.below?(y: @y) if other

    @y > y
  end

  def below?(other = nil, y: nil)
    return other.above?(y: @y) if other

    @y < y
  end

  def at?(x, y)
    @x == x && @y == y
  end

  def ==(other)
    other.at?(@x, @y)
  end

  def place(body)
    offset = body.size * 0.5
    tap do
      body.x = @x - offset
      body.y = @y - offset
    end
  end

  def inspect
    to_s
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end
