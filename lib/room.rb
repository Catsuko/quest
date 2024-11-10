class Room
  def initialize(bounds)
    @bounds = bounds
    @factions = {}
    @faction_order = []
    @tiles = bounds.map { |position| position.place(yield) } if block_given?
  end

  def add(actor, at: nil, faction: :world)
    position(from: at || @bounds.sample) do |pos|
      if !@faction_order.include?(faction)
        @factions.store(faction, [])
        @faction_order << faction
      end

      @factions.fetch(faction) << actor.move_to(pos)
      actor
    end || actor.remove
  end

  def position(x_dir = 0, y_dir = 0, from:, &block)
    @bounds.position(x_dir, y_dir, from: from) do |pos|
      block.call(pos) unless occupied?(pos)
    end
  end

  def occupied?(pos)
    all_actors.any? { |actor| actor.at?(pos) }
  end

  def update
    @phase ||= Phases::GatherIntents.new(actors_for_turn)
    @phase = @phase.update(inside: self)
  end

  def change_turn
    return [] if @faction_order.empty?

    @faction_order << @faction_order.shift
    actors_for_turn
  end

  def find_actors(faction)
    @factions.fetch(faction) { [] }
  end

  private

  def actors_for_turn
    @factions[@faction_order.first] || []
  end

  def all_actors
    @factions.values.flatten
  end
end
