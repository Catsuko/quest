module Drivers
  class Keyboard
    def initialize(key_bindings = { 's' => :up, 'a' => :left, 'w' => :down, 'd' => :right })
      @key_bindings = key_bindings
      @direction = nil
    end

    def update(actor, inside:)
      step_direction do |x_dir, y_dir|
        actor.step(x_dir, y_dir, inside: inside)
      end
      @direction = nil
    end

    def bind(input_event)
      return unless direction = @key_bindings[input_event.key]

      @direction = direction      
    end

    private

    def step_direction
      return if @direction.nil?

      case @direction
      when :up
        yield(0, 1)
      when :down
        yield(0, -1)
      when :right
        yield(1, 0)
      when :left
        yield(-1, 0)
      end
    end
  end
end
