class Actor
  def initialize(body, driver: nil)
    @body = body
    @driver = driver
  end

  def update(room)
    @driver&.update(self, inside: room)
  end

  def move_to(position)
    tap { position.place(@body) }
  end

  def at?(position)
    Position.at(@body.x, @body.y) == position
  end

  def remove
    @body.remove
  end
end
