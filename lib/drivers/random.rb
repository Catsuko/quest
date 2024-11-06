module Drivers
  class Random
    def intent
      Intents::Move.new(*random_direction)
    end

    private

    def random_direction
      @directions ||= [[0, 1], [0, -1], [1, 0], [-1, 0]]
      @directions.sample
    end
  end
end
