module Graphics
  def self.tile
    Square.new(z: 0, size: GridPosition.scale(1) - 2, color: 'navy')
  end

  def self.stone_pillar
    Square.new(z: 1, size: GridPosition.scale(0.7), color: 'gray')
  end

  def self.hero
    Square.new(z: 1, size: GridPosition.scale(0.4), color: 'green')
  end
end
