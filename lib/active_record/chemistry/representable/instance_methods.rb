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
