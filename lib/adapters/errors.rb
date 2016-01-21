module Adapters
  # Raised, when another way to cast from X to Y defined
  # @see Adapters::Bindings
  AlreadyBoundError = Class.new(StandardError)
  # Raised, when adapter to cast not found
  # @see Adapters::Bindings
  AdapterNotFound = Class.new(StandardError)
  # Raised, when interface not defined for Adapters::Adapter
  # @see Adapters::Adapter
  TargetInterfaceNotDefined = Class.new(StandardError)
  # Raised, when interface did not received bindings for all interface methdos
  # @see Adapters::Interface
  IncompleteInterfaceError = Class.new(StandardError)
end
