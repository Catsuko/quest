class Actors
  def initialize
    @player = nil
    @actors = []
    @update_count = 0
  end

  def add(actor, player: false)
    tap do
      if player
        @player = actor
      else
        @actors << actor
      end
    end
  end

  def update(room)
    tap do
      if @player && @update_count.even?
        next unless @player.update(room)

      else
        @actors.each { |actor| actor.update(room) }
      end

      @update_count += 1
    end
  end

  def remove_all
    tap do
      @player&.remove
      @actors.each(&:remove) 
    end
  end

  def occupies?(position)
    @player&.at?(position) || @actors.any? { |actor| actor.at?(position) }
  end
end
