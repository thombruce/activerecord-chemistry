require 'active_record/chemistry/extendable/migration'
require 'active_record/chemistry/extendable/relation'

module ActiveRecord
  module Chemistry
    module Extendable
      include ActiveRecord::Chemistry::Extendable::Migration
      include ActiveRecord::Chemistry::Extendable::Relation
    end
  end
end
