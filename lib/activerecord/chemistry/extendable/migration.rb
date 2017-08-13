module ActiveRecord
  module Chemistry
    module Extendable
      module Migration
        module TableDefinition
          def extended_by(*args)
            options = args.extract_options!
            args.each do |col|
              references(col, options)
            end
          end
        end

        module Table
          include TableDefinition

          def remove_extended_by(*args)
            options = args.extract_options!
            args.each do |col|
              @base.remove_reference(@name, col, options)
            end
          end
        end
      end
    end
  end
end
