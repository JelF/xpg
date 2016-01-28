class ARModel < ActiveRecord::Base
  class Migration < ActiveRecord::Migration
    def up
      create_table :ar_models do |t|
        t.string :foo
        t.string :bar
      end
    end
  end
end

ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym :ar
end
