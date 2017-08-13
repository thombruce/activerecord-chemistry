require 'active_support'
require 'active_record'
require 'active_record/chemistry/version'
require 'active_record/chemistry/actable'
require 'active_record/chemistry/extendable'
require 'active_record/chemistry/representable'

module ActiveRecord
  class Base
    include Chemistry::Actable::Relation
    include Chemistry::Extendable::Relation
    include Chemistry::Representable::Relation
  end

  module ConnectionAdapters
    class TableDefinition
      include Chemistry::Actable::Migration::TableDefinition
      include Chemistry::Extendable::Migration::TableDefinition
      include Chemistry::Representable::Migration::TableDefinition
    end

    class Table
      include Chemistry::Actable::Migration::Table
      include Chemistry::Extendable::Migration::Table
      include Chemistry::Representable::Migration::Table
    end
  end
end
