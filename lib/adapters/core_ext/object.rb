# Core extensions to Object
class Object
  # @see Adapters::Bindings#cast
  def cast(to)
    Adapters.cast(self, to)
  end
end
