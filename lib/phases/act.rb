module Phases
  class Act
    def initialize(actors_by_intent)
      @actors_by_intent = actors_by_intent
    end

    def update(inside:)
      @actors_by_intent.each { |actor, intent| intent.act(actor, inside: inside) }
      GatherIntents.new(inside.change_turn)
    end
  end
end
