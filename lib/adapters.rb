require 'adapters/errors'
require 'active_support/core_ext/module/delegation.rb'

# Adapters is a built-in library, describing sort of interface convertors.
# E.g, you want to extract table name from AR. You can write `x.table_name`,
# or `Adapters.from(x).to(YourLib::ITableName).table_name`. The point is make an
# well-scoped interface, which would never be overriden by mistake
module Adapters
  autoload :Bindings, 'adapters/bindings'

  class << self
    delegate :cast, to: Bindings
  end
end
