require 'active_record/chemistry/actable/migration'
require 'active_record/chemistry/actable/relation'

module ActiveRecord
  module Chemistry
    module Actable
      include ActiveRecord::Chemistry::Actable::Migration
      include ActiveRecord::Chemistry::Actable::Relation
    end
  end
end
