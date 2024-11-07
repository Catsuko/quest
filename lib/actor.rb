class Actor
  def initialize(body, driver: nil)
    @body = body
    @driver = driver
  end

  def bind(environment)
    @driver&.bind(environment)
  end

  def intent
    @driver ? @driver.intent : Intents::Pass
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
    Position.at(@body.x, @body.y) == other_position
  end

  def remove
    @body.remove
  end

  private

  def position
    Position.at(@body.x, @body.y)
  end
end
