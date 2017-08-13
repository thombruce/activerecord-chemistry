module ActiveRecord
  module Chemistry
    module Representable
      module Relation
        extend ActiveSupport::Concern

        module ClassMethods
          def represents(name, scope = nil, options = {})
            belongs_to(name, scope, options)
          end

          def representable(name, scope = nil, options = {})
            has_many(name, scope, options)
          end
        end
      end
    end
  end
end
