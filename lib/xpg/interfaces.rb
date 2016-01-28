module XPG
  # Describes a model, to which row set could be unloaded
  ILModel = Adapters.build_interface(:build)
  # Describes a model, from which query could be loaded
  IRModel =
    Adapters.build_interface(:table_name, :rows, :convert_row, :association)
end
