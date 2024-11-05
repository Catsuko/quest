class Room
  def initialize(bounds, actors: Actors.new)
    @bounds = bounds
    @actors = actors
    @tiles = bounds.map { |position| position.place(yield) } if block_given?
  end

  def add(actor, player: false, at: nil)
    position(from: at || @bounds.sample) do |pos|
      @actors.add(actor.move_to(pos), player: player)
      actor
    end || actor.remove
  end

  def position(x_dir = 0, y_dir = 0, from:, &block)
    @bounds.position(x_dir, y_dir, from: from) do |pos|
      block.call(pos) unless occupied?(pos)
    end
  end

  def occupied?(pos)
    @actors.occupies?(pos)
  end

  def update
    @actors.update(self)
  end

  def clear
    @actors.remove_all
    @tiles&.each(&:remove)
  end
end
