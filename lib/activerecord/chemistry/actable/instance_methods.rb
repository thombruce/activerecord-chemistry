module ActiveRecord
  module Chemistry
    module Actable
      module InstanceMethods
        def actable_must_be_valid
          unless acting_as.valid?
            acting_as.errors.each do |attribute, message|
              errors.add(attribute, message) unless errors[attribute].include?(message)
            end
          end
        end
        protected :actable_must_be_valid

        def respond_to?(name, include_private = false, as_original_class = false)
          if as_original_class
            super(name, include_private)
          else
            super(name, include_private) || acting_as.respond_to?(name)
          end
        end

        def self_respond_to?(name, include_private = false)
          respond_to? name, include_private, true
        end

        def method_missing(method, *args, &block)
          if !self_respond_to?(method) && acting_as.respond_to?(method)
            acting_as.send(method, *args, &block)
          else
            super
          end
        end
      end
    end
  end
end