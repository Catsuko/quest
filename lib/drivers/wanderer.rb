module Drivers
  class Wanderer
    class << self
      def anywhere
        @anywhere ||= new(leash_distance: -1)
      end
    end

    def initialize(leash_distance: 2)
      @leash_distance = leash_distance
    end

    def intent(actor, *)
      position = actor.position
      @origin ||= position
      selected_direction = valid_directions(position, origin: @origin).sample

      return Intents::Move.new(*selected_direction) if selected_direction

      @origin = position
      Intents::Pass
    end

    private

    def valid_directions(from, origin:)
      @directions ||= [[0, 1], [0, -1], [1, 0], [-1, 0]]
      @directions.reject do |dir|
        @leash_distance.positive? && from.step(*dir).count_steps_to(origin) > @leash_distance
      end
    end
  end
end
