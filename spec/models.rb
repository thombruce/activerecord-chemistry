require_relative 'database_helper'

require 'activerecord/chemistry'

class Person < ActiveRecord::Base
  actable :user
  validates_format_of :slug, with: /\A[a-z]+\z/i
end

class User < ActiveRecord::Base
  acts_as :person
end

class PersonalName < ActiveRecord::Base
  representable :display_names
  validates_format_of :appellation, with: /\A[a-z ]+\z/i
end

class DisplayName < ActiveRecord::Base
  represents :personal_name
end

class Confirmable < ActiveRecord::Base
  extends :email
end

class Email < ActiveRecord::Base
  extendable_by :confirmable
end

def initialize_schema
  initialize_database do
    create_table :people do |t|
      t.string :slug
      t.timestamps null: true
    end
    create_table :users do |t|
      t.acts_as :person
    end
    create_table :personal_names do |t|
      t.string :appellation 
      t.timestamps null: true
    end
    create_table :display_names do |t|
      t.represents :personal_name
    end
    create_table :confirmables do |t|
    end
    create_table :emails do |t|
      t.string :address
      t.extended_by :confirmable
      t.timestamps null: true
    end
  end
end
