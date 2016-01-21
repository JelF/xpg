module Adapters
  # Contains adapters bindins interface.
  # After you call bind or bind_instances it will remember them
  module Bindings
    class << self

      # Casts object to interface using matching adapter
      def cast(from, to)
        resolver(from, to).new(from).cast
      end

      # Private api
      def _bind(from, adapter)
        key = [from, adapter.interface]

        if bindings.key?(key)
          fail AlreadyBoundError,
               "Object #{from} already bound to #{fetch(key)}"
        else
          bindings[key] = adapter
          nil
        end
      end

      # Private api
      def _bind_instances(from, adapter)
        key = [from, adapter.interface]

        if instance_bindings.key?(key)
          fail AlreadyBoundError,
               "Isntances of #{from} already bound to #{fetch(key)}"
        else
          instance_bindings[key] = adapter
          nil
        end
      end

      private

      # resolves adapter to cast `from` to `to`
      def resolver(from, to)
        bindings.fetch([from, to]) { instance_bindings.fetch([from.class, to]) }
      rescue KeyError
        fail AdapterNotFound, "Unable to cast #{from} to #{to}"
      end

      # Contains all defined bindings
      def bindings
        @bindings ||= {}
      end

      # Contains all defined instance bindings
      def instance_bindings
        @instance_bindings ||= {}
      end
    end
  end
end
