class Actor
  def initialize(body)
    @body = body
  end

  def update(_room)
  end

  def move_to(position)
    tap { position.place(@body) }
  end

  def at?(position)
    body_position == position
  end

  def clear
    @body.clear
  end

  private

  def body_position
    GridPosition.at(@body.x, @body.y)
  end
end
