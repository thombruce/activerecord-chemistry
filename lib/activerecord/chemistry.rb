require 'active_support'
require 'active_record'
require 'activerecord/chemistry/version'
require 'activerecord/chemistry/actable'
require 'activerecord/chemistry/extendable'
require 'activerecord/chemistry/representable'

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
  end

  module ConnectionAdapters
    class Table
      include ActiveRecord::Chemistry::Actable::Migration::Table
      include ActiveRecord::Chemistry::Extendable::Migration::Table
      include ActiveRecord::Chemistry::Representable::Migration::Table
    end
  end
end
