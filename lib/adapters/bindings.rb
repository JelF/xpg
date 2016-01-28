module Adapters
  # Contains adapters bindins interface.
  # After you call bind or bind_instances it will remember them
  module Bindings
    class << self
      # Casts object to interface using matching adapter
      # @param from object to be casted
      # @param to resulting interface
      # @return [to] object casted to interface
      # @raise AdapterNotFound
      def cast(from, to)
        resolver(from, to).new(from).cast
      end

      # @api private
      # @param from object, which could be casted by adapter
      # @param adapter adapter to use for this object
      def _bind(from, adapter)
        key = [from, adapter.interface]

        if bindings.key?(key)
          fail AlreadyBoundError,
               "Object #{from} already bound to #{bindings.fetch(key)}"
        else
          bindings[key] = adapter
          nil
        end
      end

      # @api private
      # @param from object, which could be casted by adapter
      # @param adapter adapter to use for this object
      def _bind_instances(from, adapter)
        key = [from, adapter.interface]

        if instance_bindings.key?(key)
          fail AlreadyBoundError,
               "Isntances of #{from} already bound to "\
               "#{instance_bindings.fetch(key)}"
        else
          instance_bindings[key] = adapter
          nil
        end
      end

      private

      # @param from object to be casted
      # @param to resulting interface
      # @return adapter which can cast `from` to `to`
      # @raise AdapterNotFound otherwise
      def resolver(from, to)
        result = resolve_from_ancestors(from, to, bindings)
        result ||= resolve_from_ancestors(from.class, to, instance_bindings)
        fail AdapterNotFound, "Unable to cast #{from} to #{to}" unless result

        result
      end

      # @param from object to be casted
      # @param to resulting interface
      # @param scope [Hash([Object, interface] => adapter)] lookup scope
      # @return adapter which can cast `from` to `to`
      def resolve_from_ancestors(from, to, scope)
        ancestors = from.respond_to?(:ancestors) ? from.ancestors : [from]

        ancestors.find do |ancestor|
          adapter = scope[[ancestor, to]]
          break adapter if adapter
        end
      end

      # Contains all defined bindings
      # @return [Hash([Object, interface] => adapter)]
      def bindings
        @bindings ||= {}
      end

      # Contains all defined instance bindings
      # @return [Hash([Module, interface] => adapter)]
      def instance_bindings
        @instance_bindings ||= {}
      end
    end
  end
end
