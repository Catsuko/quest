module Phases
  class GatherIntents
    def initialize(actors, timeout: 1000)
      @actors = actors
      @timeout = timeout
      @start_time = timestamp
    end

    def update(inside:)
      return next_phase if ready? || timeout?

      self
    end

    private

    def timeout?
      @start_time < timestamp - @timeout
    end

    def timestamp
      (Time.now.to_f * 1000)
    end

    def ready?
      actors_by_intent.all? do |actor, intent|
        intent || check_intent(actor)
      end
    end

    def next_phase
      Act.new(actors_by_intent.compact)
    end

    def actors_by_intent
      @actors_by_intent ||= @actors.to_h { |actor| [actor, nil] }
    end

    def check_intent(actor)
      intent = actor.intent
      actors_by_intent.store(actor, intent) if intent
    end
  end
end
