require 'adapters/errors'
require 'active_support/core_ext/module/delegation.rb'

# Adapters is a built-in library, describing sort of interface convertors.
# E.g, you want to extract table name from AR. You can write `x.table_name`,
# or `Adapters.from(x).to(YourLib::ITableName).table_name`. The point is make an
# well-scoped interface, which would never be overriden by mistake
module Adapters
  autoload :Bindings, 'adapters/bindings'
  autoload :Adapter, 'adapters/adapter'
  autoload :Interface, 'adapters/interface'

  class << self
    # @see Adapters::Bindings.cast
    delegate :cast, to: Bindings

    # Shortcut to build interface. Instead of `Struct`, it seems not be buggy,
    # if you inherit it or extend
    # @see Adapters::Interface
    # @param interface_methods [Array(#to_sym)]
    #   list of methods, which should be defeined on adapter
    # @return [Class]
    def build_interface(*interface_methods)
      Class.new(Interface) do
        interface_methods.each(&method(:interface_method))
      end
    end
  end
end
