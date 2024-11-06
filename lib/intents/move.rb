module Intents
  class Move
    def initialize(x_dir, y_dir)
      @x_dir = x_dir
      @y_dir = y_dir
    end

    def act(actor, inside:)
      actor.step(@x_dir, @y_dir, inside: inside)
    end
  end
end
