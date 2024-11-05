module Drivers
  class Keyboard
    def initialize(key_bindings = { 's' => :up, 'a' => :left, 'w' => :down, 'd' => :right })
      @key_bindings = key_bindings
      @direction = nil
    end

    def update(actor, inside:)
      direction = step_direction
      actor.step(*direction, inside: inside) if direction

      @direction = nil
      !direction.nil?
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
        [0, 1]
      when :down
        [0, -1]
      when :right
        [1, 0]
      when :left
        [-1, 0]
      end
    end
  end
end
