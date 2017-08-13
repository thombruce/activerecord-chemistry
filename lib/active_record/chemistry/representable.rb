require 'active_record/chemistry/representable/migration'
require 'active_record/chemistry/representable/relation'

module ActiveRecord
  module Chemistry
    module Representable
      include ActiveRecord::Chemistry::Representable::Migration
      include ActiveRecord::Chemistry::Representable::Relation
    end
  end
end
