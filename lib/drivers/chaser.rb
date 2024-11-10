module Drivers
  class Chaser
    def initialize(target_faction)
      @target_faction = target_faction
    end

    def intent(actor, inside:)
      @target ||= inside.find_actors(@target_faction).sample
      return Intents::Pass if @target.nil?

      Intents::Move.new(*step_direction(actor.position, @target.position))
    end

    private

    def step_direction(own_position, target_position)
      directions = []

      if target_position.above?(own_position)
        directions << [0, 1]
      elsif target_position.below?(own_position)
        directions << [0, -1]
      end

      if target_position.right_of?(own_position)
        directions << [1, 0]
      elsif target_position.left_of?(own_position)
        directions << [-1, 0]
      end

      directions.sample
    end
  end
end
