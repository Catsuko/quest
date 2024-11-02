class Room
  def initialize(grid)
    @grid = grid
    @actors = []
    @tiles = grid.map { |position| position.place(yield) } if block_given?
  end

  def add(actor, at: nil)
    step(from: at || @grid.sample) do |pos|
      @actors << actor.move_to(pos)
      actor
    end || actor.remove
  end

  def step(x_dir = 0, y_dir = 0, from:, &block)
    @grid.step(x_dir, y_dir, from: from) do |pos|
      block.call(pos) unless occupied?(pos)
    end
  end

  def occupied?(pos)
    @actors.any? { |actor| actor.at?(pos) }
  end

  def update
    @actors.each { |actor| actor.update(self) }
  end

  def clear
    @actors.each(&:remove)
    @tiles&.each(&:remove)
  end
end
