module ActiveRecord
  module Chemistry
    module Migration
      module TableDefinition
        def acts_as(*args)
          options = args.extract_options!
          args.each do |col|
            references(col, options)
          end
        end

        def represents(*args)
          options = args.extract_options!
          args.each do |col|
            references(col, options)
          end
        end

        def extended_by(*args)
          options = args.extract_options!
          args.each do |col|
            references(col, options)
          end
        end
      end

      module Table
        include TableDefinition

        def remove_acts_as(*args)
          options = args.extract_options!
          args.each do |col|
            @base.remove_reference(@name, col, options)
          end
        end

        def remove_represents(*args)
          options = args.extract_options!
          args.each do |col|
            @base.remove_reference(@name, col, options)
          end
        end

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
