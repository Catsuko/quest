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
    body_position == position
  end

  def remove
    @body.remove
  end

  private

  def body_position
    GridPosition.at(@body.x, @body.y)
  end
end
