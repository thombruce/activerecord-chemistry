require 'active_support'
require 'active_record'
require 'active_record/chemistry/version'
require 'active_record/chemistry/migration'

module ActiveRecord
  class Base
  end

  module ConnectionAdapters
    class TableDefinition
      include Chemistry::Migration::TableDefinition
    end

    class Table
      include Chemistry::Migration::Table
    end
  end
end
