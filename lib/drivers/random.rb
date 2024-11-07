module Drivers
  module Random
    def self.intent
      @directions ||= [[0, 1], [0, -1], [1, 0], [-1, 0]]
      Intents::Move.new(*@directions.sample)
    end

    def self.bind(*); end
  end
end
