require 'activerecord/chemistry/representable/migration'
require 'activerecord/chemistry/representable/relation'

module ActiveRecord
  module Chemistry
    module Representable
      include ActiveRecord::Chemistry::Representable::Migration
      include ActiveRecord::Chemistry::Representable::Relation
    end
  end
end
