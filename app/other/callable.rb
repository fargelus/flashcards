# Simple callable interface that allows
# call objects through call class methods
# frozen_string_literal: true

class Callable
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
