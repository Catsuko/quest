require 'behavior_tree'

module Drivers
  class Tree
    class << self
      def wander
        new(BehaviorTree::Builder.build do
          task {
            context.store(:intent, Intents::Move.new(*Position.cardinal_directions.sample))
            status.success!
          }
        end)
      end

      def chase(target_faction)
        new(BehaviorTree::Builder.build do
          sequence do
            task {
              target = context.fetch(:room).find_actors(target_faction).sample

              if target
                context.store(:target, target)
                status.success!
              else
                @status.fail!
              end
            }
            task {
              own_position = context.fetch(:actor).position
              target_position = context.fetch(:target).position
              directions = []

              if target_position.above?(own_position)
                directions << [0, 1]
              elsif target_position.below?(own_position)
                directions << [0, -1]
              end

              if target_position.right_of?(own_position)
                directions << [1, 0]
              elsif
                directions << [-1, 0]
              end

              if next_step = directions.sample
                context.store(:intent, Intents::Move.new(*next_step))
              else
                status.fail!
              end
            }
          end
        end)
      end
    end

    def initialize(tree)
      @tree = tree
      @tree.context = {}
    end

    def intent(actor, inside:)
      @tree.context[:actor] = actor
      @tree.context[:room] = inside
      @tree.tick!
      @tree.context.fetch(:intent, Intents::Pass)
    end
  end
end
