require 'ruby2d'

require_relative 'quest'
require_relative 'lib/drivers/keyboard'
require_relative 'lib/graphics'

tile_size = 64
Position.scale = tile_size
room_min_pos = Position.at(tile_size, tile_size)
room_bounds = Bounds.new(room_min_pos, room_min_pos.step(5, 5))
room = Room.new(room_bounds, &Graphics.method(:tile))

keyboard_driver = Drivers::Keyboard.new
hero = room.add(Actor.new(Graphics.hero, driver: keyboard_driver))

stone_pillars = 10.times { room.add(Actor.new(Graphics.stone_pillar)) }

on :key_down, &keyboard_driver.method(:bind)

update do
  room.update
end

set title: 'QUEST', borderless: true
show
