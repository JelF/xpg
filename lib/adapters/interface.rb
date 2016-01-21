module Adapters
  # Abstract interface implementation
  class Interface
    # @return [Array(Symbol)] all methods required to build interface
    def self.interface_methods
      @interface_methods ||= []
    end

    # Defines an interface method, which is required to build interface
    # As usual, you only should define method with same name in adapter
    # @param name [#to_sym] interface method name
    # @return name
    def self.interface_method(name)
      interface_methods << name.to_sym

      define_method(name) do |*args, &block|
        _bindings.fetch(name).call(*args, &block)
      end
    end

    # Builds interface from a hash, provided by adapter.
    # @param bindings [Hash(Symbol => #call)]
    # @raise [IncompleteInterfaceError] if any interface method is missing
    def initialize(bindings)
      self._bindings = bindings

      missing_methods = self.class.interface_methods - bindings.keys
      return if missing_methods.empty?
      fail IncompleteInterfaceError,
           "Missing methods: #{missing_methods.join(', ')}"
    end

    private

    attr_accessor :_bindings
  end
end
