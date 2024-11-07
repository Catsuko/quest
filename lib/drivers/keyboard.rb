module Drivers
  class Keyboard
    def initialize(key_bindings = { 's' => :up, 'a' => :left, 'w' => :down, 'd' => :right })
      @key_bindings = key_bindings
      @direction = nil
    end

    def intent
      direction = step_direction
      @direction = nil
      Intents::Move.new(*direction) if direction
    end

    def bind(environment)
      environment.on(:key_down, &method(:bind_to_key_down))
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

    def bind_to_key_down(input_event)
      return unless direction = @key_bindings[input_event.key]

      @direction = direction      
    end
  end
end
