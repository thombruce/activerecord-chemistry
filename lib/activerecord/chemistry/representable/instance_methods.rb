module ActiveRecord
  module Chemistry
    module Representable
      module InstanceMethods
        def representable_must_be_valid
          unless representing.valid?
            representing.errors.each do |attribute, message|
              errors.add(attribute, message) unless errors[attribute].include?(message)
            end
          end
        end
        protected :representable_must_be_valid

        def find_by_or_keep_representable
          if representing.new_record? && @findable = representing_model.find_by(self.representing.attributes.reject { |k| ['id', 'created_at', 'updated_at'].include? k })
            self.representing = @findable
            #@findable.association(representing_model.representable_reflection.name.to_sym).add_to_target(self, true)
          end
        end

        def update_or_instantiate_representable
          if representing.changed? && representing.send(representing_model.representable_reflection.name.to_sym).count > 1
            self.representing = representing.dup
          end
        end

        def respond_to?(name, include_private = false, as_original_class = false)
          if as_original_class
            super(name, include_private)
          else
            super(name, include_private) || representing.respond_to?(name)
          end
        end

        def self_respond_to?(name, include_private = false)
          respond_to? name, include_private, true
        end

        def method_missing(method, *args, &block)
          if !self_respond_to?(method) && representing.respond_to?(method)
            representing.send(method, *args, &block)
          else
            super
          end
        end
      end
    end
  end
end
