module ActiveRecord
  module Chemistry
    module Extendable
      module Relation
        extend ActiveSupport::Concern

        module ClassMethods
          def extendable_by(name, scope = nil, options = {})
            belongs_to(name, scope, options)
          end

          def extends(name, scope = nil, options = {})
            has_one(name, scope, options)
          end
        end
      end
    end
  end
end
