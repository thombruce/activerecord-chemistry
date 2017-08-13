module ActiveRecord
  module Chemistry
    module Representable
      module Relation
        extend ActiveSupport::Concern

        included do
        end

        class_methods do
          def represents(name, scope = nil, options = {})
            if Hash === scope
              options = scope
              scope = nil
            end
            reflections = belongs_to(name, scope, options)
            default_scope -> { includes(name) }
            validate :representable_must_be_valid

            cattr_reader(:representing_reflection) { reflections.stringify_keys[name.to_s] }
            cattr_reader(:representing_model) { (options[:class_name] || name.to_s.camelize).constantize }
            class_eval "def #{name}; super || build_#{name}(representing_model.representable_reflection.name => [self]); end"
            alias_method :representing, name
            alias_method :representing=, "#{name}=".to_sym
            include Representable::InstanceMethods
          end

          def representable(name, scope = nil, options = {})
            reflections = has_many(name, scope, options)
            cattr_reader(:representable_reflection) { reflections.stringify_keys[name.to_s] }
          end
        end
      end
    end
  end
end
