require 'active_support/core_ext/module/delegation.rb'

module Adapters
  # Defines abstract adapter
  class Adapter
    # @param interface if provided, sets target interface of adapter
    # @return target interface of adapter
    # @raise TartetInterfaceNotDefined unless interface is set
    def self.interface(interface = nil)
      if interface
        @interface = interface
      elsif @interface
        @interface
      else
        fail TargetInterfaceNotDefined,
             "Target interface not defined for #{name}"
      end
    end

    # bind adapter to from => interface
    def self.bind(from)
      Bindings._bind(from, self)
    end

    # bind adapter to any instance of from or classes
    # inherited / included it => interface
    def self.bind_instances(from)
      Bindings._bind_instances(from, self)
    end

    delegate :interface, to: 'self.class'

    # Object to be cast to interface
    attr_reader :object

    # @param object [Object] Object to be cast to interface
    def initialize(object)
      @object = object
    end

    # Casts object to interface
    # @return [interface] instance of interface
    def cast
      interface.new(interface.interface_methods.map { |m| [m, method(m)] }.to_h)
    end
  end
end
