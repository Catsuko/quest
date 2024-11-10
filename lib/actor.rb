class Actor
  def initialize(body, driver: nil)
    @body = body
    @driver = driver
  end

  def intent(inside)
    @driver ? @driver.intent(self, inside: inside) : Intents::Pass
  end

  def step(x_dir, y_dir, inside:)
    inside.position(x_dir, y_dir, from: position) do |target_position|
      move_to(target_position)
    end
  end

  def move_to(target_position)
    tap { target_position.place(@body) }
  end

  def at?(other_position)
    position == other_position
  end

  def remove
    @body.remove
  end

  def position
    Position.at(@body.x, @body.y)
  end
end
