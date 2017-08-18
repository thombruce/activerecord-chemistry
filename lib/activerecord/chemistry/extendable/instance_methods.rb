module ActiveRecord
  module Chemistry
    module Extendable
      module InstanceMethods
        def extendable_must_be_valid
          unless extendable.valid?
            extendable.errors.each do |attribute, message|
              errors.add(attribute, message) unless errors[attribute].include?(message)
            end
          end
        end
        protected :extendable_must_be_valid

        def respond_to?(name, include_private = false, as_original_class = false)
          if as_original_class
            super(name, include_private)
          else
            super(name, include_private) || extendable.respond_to?(name)
          end
        end

        def self_respond_to?(name, include_private = false)
          respond_to? name, include_private, true
        end

        def method_missing(method, *args, &block)
          if !self_respond_to?(method) && extendable.respond_to?(method)
            extendable.send(method, *args, &block)
          else
            super
          end
        end
      end
    end
  end
end