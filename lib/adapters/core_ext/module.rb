# Core extensions to Module
class Module
  # bind adapter to from => interface
  # @see Adapters::Adapter#bind
  def class_adapter(adapter)
    adapter.bind(self)
  end

  # bind adapter to any instance of from or classes
  # inherited / included it => interface
  # @see Adapters::Adapter#bind_instances
  def instance_adapter(adapter)
    adapter.bind_instances(self)
  end
end
