require 'active_support'
require 'active_record'
require 'active_record/chemistry/version'
require 'active_record/chemistry/actable'
require 'active_record/chemistry/extendable'
require 'active_record/chemistry/representable'

module ActiveRecord
  class Base
    include ActiveRecord::Chemistry::Actable::Relation
    include ActiveRecord::Chemistry::Extendable::Relation
    include ActiveRecord::Chemistry::Representable::Relation
  end

  module ConnectionAdapters
    class TableDefinition
      include ActiveRecord::Chemistry::Actable::Migration::TableDefinition
      include ActiveRecord::Chemistry::Extendable::Migration::TableDefinition
      include ActiveRecord::Chemistry::Representable::Migration::TableDefinition
    end

    class Table
      include ActiveRecord::Chemistry::Actable::Migration::Table
      include ActiveRecord::Chemistry::Extendable::Migration::Table
      include ActiveRecord::Chemistry::Representable::Migration::Table
    end
  end
end
