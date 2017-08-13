require 'activerecord/chemistry/actable/migration'
require 'activerecord/chemistry/actable/relation'

module ActiveRecord
  module Chemistry
    module Actable
      include ActiveRecord::Chemistry::Actable::Migration
      include ActiveRecord::Chemistry::Actable::Relation
    end
  end
end
