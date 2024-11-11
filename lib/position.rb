class Position
  class << self
    def at(x, y)
      new(translate(x), translate(y))
    end

    def translate(coord)
      ((coord / @scale).floor * @scale) + @scale_offset
    end

    def scale(n = 1)
      n * (@scale)
    end

    def scale=(n)
      @scale_offset = (n * 0.5).floor
      @scale = n
    end

    def cardinal_directions
      @cardinal_directions ||= [[0, 1], [1, 0], [-1, 0], [0, -1]]
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
    body.tap do
      offset = body.size * 0.5
      body.x = @x - offset
      body.y = @y - offset
    end
  end

  def count_steps_to(other = nil, x: nil, y: nil)
    return other.count_steps_to(x: @x, y: @y) if other

    ((@x - x).abs + (@y - y).abs) / self.class.scale
  end

  def inspect
    to_s
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end
