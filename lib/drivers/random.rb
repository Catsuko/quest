module Drivers
  class Random
    def update(actor, inside:)
      @directions ||= [[0, 1], [0, -1], [1, 0], [-1, 0]]
      actor.step(*@directions.sample, inside: inside)
    end
  end
end
