module XPG
  # Describes a model, to which row set could be unloaded
  # @interface_method build [[{}] => Object]
  #   builds instances from RowSet
  ILModel = ::Adapters.build_interface(:build)

  # Describes a model, from which query could be loaded
  # @interface_method table_name [=> String]
  #   provides name of associated table
  # @interface_method rows [=> [Symbol]]
  #   provides all rows of RModel
  # @interface_method sanitize_row [Symbol, Object => String]
  #   sanitizes value for row
  # @interface_method sanitize_row [Symbol, [Object] => [String]]
  #   sanitizes values for rows
  # @interface_method association [Symbol => IRModel]
  #   gets association
  IRModel = ::Adapters.build_interface(:table_name, :rows, :sanitize_row,
                                       :association)
end
