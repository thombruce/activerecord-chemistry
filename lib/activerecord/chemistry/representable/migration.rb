module ActiveRecord
  module Chemistry
    module Representable
      module Migration
        module TableDefinition
          def represents(*args)
            options = args.extract_options!
            args.each do |col|
              references(col, options)
            end
          end
        end

        module Table
          include TableDefinition

          def remove_represents(*args)
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
