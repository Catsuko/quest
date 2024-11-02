require 'ruby2d'

require_relative 'quest'
require_relative 'lib/graphics'

tile_size = 64
GridPosition.scale = tile_size
grid_origin = GridPosition.at(tile_size, tile_size)
grid = Grid.new(grid_origin, grid_origin.step(5, 5))
room = Room.new(grid, &Graphics.method(:tile))
hero = room.add(Actor.new(Graphics.hero))
stone_pillars = 10.times { room.add(Actor.new(Graphics.stone_pillar)) }

update do
  room.update
end

show
