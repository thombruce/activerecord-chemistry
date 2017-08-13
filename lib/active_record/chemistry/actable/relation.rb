module ActiveRecord
  module Chemistry
    module Actable
      module Relation
        extend ActiveSupport::Concern

        module ClassMethods
          def acts_as(name, scope = nil, options = {})
            belongs_to(name, scope, options)
          end

          def actable(name, scope = nil, options = {})
            has_one(name, scope, options)
          end
        end
      end
    end
  end
end
