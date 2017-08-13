require_relative 'database_helper'

require 'active_record/chemistry'

class Entity < ActiveRecord::Base
  actable # has_one [classes]
end

class User < ActiveRecord::Base
  acts_as :entity # belongs_to :entity
end

class App < ActiveRecord::Base
  acts_as :entity # belongs_to :entity
end

class PersonalName < ActiveRecord::Base
  representable # has_many [classes]
end

class DisplayName < ActiveRecord::Base
  represents :personal_name # belongs_to :personal_name
end

class Confirmable < ActiveRecord::Base
  extends # has_one [classes]
end

class Email < ActiveRecord::Base
  extendable_by :confirmable # belongs_to :confirmable
end

class Telephone < ActiveRecord::Base
  extendable_by :confirmable # belongs_to :confirmable
end

def initialize_schema
  initialize_database do
    create_table :entities do |t|
      t.timestamps null: true
    end
    create_table :users do |t| # has relation
      t.acts_as :entity
      # t.timestamps null: true
    end
    create_table :apps do |t| # has relation
      t.acts_as :entity
      # t.timestamps null: true
    end
    create_table :personal_names do |t|
      t.timestamps null: true
    end
    create_table :display_names do |t| # has relation
      t.represents :personal_name
      # t.timestamps null: true
    end
    create_table :confirmables do |t|
      # t.timestamps null: true
    end
    create_table :emails do |t| # has relation
      t.extended_by :confirmable
      t.timestamps null: true
    end
    create_table :telephones do |t| # has relation
      t.extended_by :confirmable
      t.timestamps null: true
    end
  end
end

initialize_schema
