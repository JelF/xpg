require 'active_record'

module XPG
  module Adapters
    # Casts AR to ILModel
    class ARLModelAdapter < ::Adapters::Adapter
      interface ILModel
      bind ActiveRecord::Base

      # @see XPG::ILModel
      def build(array)
        array.map(&object.method(:new))
      end
    end
  end
end
