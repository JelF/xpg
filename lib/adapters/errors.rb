module Adapters
  # Raised, when another way to cast from X to Y defined
  AlreadyBoundError = Class.new(StandardError)
  # Raised, when adapter to cast not found
  AdapterNotFound = Class.new(StandardError)
end
