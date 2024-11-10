require 'ruby2d'

require_relative 'quest'
require_relative 'lib/drivers/keyboard'
require_relative 'lib/drivers/wanderer'
require_relative 'lib/drivers/chaser'
require_relative 'lib/graphics'

tile_size = 64
Position.scale = tile_size
room_min_pos = Position.at(tile_size, tile_size)
room_bounds = Bounds.new(room_min_pos, room_min_pos.step(11, 7))
room = Room.new(room_bounds, &Graphics.method(:tile))

keyboard_driver = Drivers::Keyboard.new
keyboard_driver.bind(self)
hero = room.add(Actor.new(Graphics.hero, driver: keyboard_driver), faction: :player)

chaser = Drivers::Chaser.new(:player)
enemy = room.add(Actor.new(Graphics.enemy, driver: Drivers::Wanderer.anywhere))
enemy = room.add(Actor.new(Graphics.enemy, driver: chaser))
enemy = room.add(Actor.new(Graphics.enemy, driver: chaser))

stone_pillars = 5.times { room.add(Actor.new(Graphics.stone_pillar)) }

update { room.update }

set title: 'QUEST', borderless: true, width: 14 * tile_size, height: 10 * tile_size
show
