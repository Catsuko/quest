class Room
  def initialize(bounds)
    @bounds = bounds
    @actors = []
    @tiles = bounds.map { |position| position.place(yield) } if block_given?
  end

  def add(actor, at: nil)
    position(from: at || @bounds.sample) do |pos|
      @actors << actor.move_to(pos)
      actor
    end || actor.remove
  end

  def position(x_dir = 0, y_dir = 0, from:, &block)
    @bounds.position(x_dir, y_dir, from: from) do |pos|
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
