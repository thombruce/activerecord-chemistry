require 'activerecord/chemistry/extendable/instance_methods'

module ActiveRecord
  module Chemistry
    module Extendable
      module Relation
        extend ActiveSupport::Concern

        module ClassMethods
          def extendable_by(name, scope = nil, options = {})
            reflections = belongs_to(name, scope, options.merge(dependent: :destroy, optional: true))
            cattr_reader(:extended_by_reflection) { reflections.stringify_keys[name.to_s] }
          end

          def extends(name, scope = nil, options = {})
            if Hash === scope
              options = scope
              scope = nil
            end
            options[:dependent] ||= :nullify
            reflections = has_one(name, scope, options)
            default_scope -> { includes(name) }
            validate :extendable_must_be_valid

            cattr_reader(:extendable_reflection) { reflections.stringify_keys[name.to_s] }
            cattr_reader(:extendable_model) { (options[:class_name] || name.to_s.camelize).constantize }
            class_eval "def #{name}; super || build_#{name}(extendable_model.extended_by_reflection.name => self); end"
            alias_method :extendable, name
            alias_method :extendable=, "#{name}=".to_sym
            include Extendable::InstanceMethods
          end
        end
      end
    end
  end
end
