require 'activerecord/chemistry/actable/instance_methods'

module ActiveRecord
  module Chemistry
    module Actable
      module Relation
        extend ActiveSupport::Concern

        included do
        end

        class_methods do
          def acts_as(name, scope = nil, options = {})
            if Hash === scope
              options = scope
              scope = nil
            end
            reflections = belongs_to(name, scope, options.merge(dependent: :destroy))
            default_scope -> { includes(name) }
            validate :actable_must_be_valid

            cattr_reader(:acting_as_reflection) { reflections.stringify_keys[name.to_s] }
            cattr_reader(:acting_as_model) { (options[:class_name] || name.to_s.camelize).constantize }
            class_eval "def #{name}; super || build_#{name}(acting_as_model.actable_reflection.name => self); end"
            alias_method :acting_as, name
            alias_method :acting_as=, "#{name}=".to_sym
            include Actable::InstanceMethods
          end

          def actable(name, scope = nil, options = {})
            reflections = has_one(name, scope, options)
            cattr_reader(:actable_reflection) { reflections.stringify_keys[name.to_s] }
          end
        end
      end
    end
  end
end
