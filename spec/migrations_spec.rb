require 'database_helper'
require 'activerecord/chemistry'

class User < ActiveRecord::Base
end

class DisplayName < ActiveRecord::Base
end

class Email < ActiveRecord::Base
end

class RemoveActsAsFromUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.remove_acts_as :person
    end
  end
end

class RemoveRepresentsFromDisplayNames < ActiveRecord::Migration[5.1]
  def change
    change_table :display_names do |t|
      t.remove_represents :personal_name
    end
  end
end

class RemoveExtendedByFromEmails < ActiveRecord::Migration[5.1]
  def change
    change_table :emails do |t|
      t.remove_extended_by :confirmable
    end
  end
end

RSpec.describe ".acts_as" do
  context "in .create_table block" do
    # after { initialize_schema }

    it "creates reference columns with given names" do
      initialize_database do
        create_table(:people) { |t| t.string :name }
        create_table(:users) { |t| t.acts_as :person }
      end
      expect(User.column_names).to include('person_id')
    end
  end
end

RSpec.describe ".remove_acts_as" do
  context 'in .modify_table block' do
    before do
      initialize_database do
        create_table(:people) { |t| t.string :name }
        create_table(:users) { |t| t.acts_as :person }
      end
    end
    it 'removes reference columns with given names' do
      migration = RemoveActsAsFromUsers.new
      migration.exec_migration(ActiveRecord::Base.connection, :up)
      User.reset_column_information
      expect(User.column_names).not_to include('person_id')
    end
  end
end

RSpec.describe ".represents" do
  context "in .create_table block" do
    # after { initialize_schema }

    it "creates reference columns with given names" do
      initialize_database do
        create_table(:personal_names) { |t| t.string :name }
        create_table(:display_names) { |t| t.represents :personal_name }
      end
      expect(DisplayName.column_names).to include('personal_name_id')
    end
  end
end

RSpec.describe ".remove_represents" do
  context 'in .modify_table block' do
    before do
      initialize_database do
        create_table(:personal_names) { |t| t.string :name }
        create_table(:display_names) { |t| t.represents :personal_name }
      end
    end
    it 'removes reference columns with given names' do
      migration = RemoveRepresentsFromDisplayNames.new
      migration.exec_migration(ActiveRecord::Base.connection, :up)
      DisplayName.reset_column_information
      expect(DisplayName.column_names).not_to include('personal_name_id')
    end
  end
end

RSpec.describe ".extended_by" do
  context "in .create_table block" do
    # after { initialize_schema }

    it "creates reference columns with given names" do
      initialize_database do
        create_table(:confirmables) { |t| t.string :name }
        create_table(:emails) { |t| t.extended_by :confirmable }
      end
      expect(Email.column_names).to include('confirmable_id')
    end
  end
end

RSpec.describe ".remove_extended_by" do
  context 'in .modify_table block' do
    before do
      initialize_database do
        create_table(:confirmables) { |t| t.string :name }
        create_table(:emails) { |t| t.extended_by :confirmable }
      end
    end
    it 'removes reference columns with given names' do
      migration = RemoveExtendedByFromEmails.new
      migration.exec_migration(ActiveRecord::Base.connection, :up)
      Email.reset_column_information
      expect(Email.column_names).not_to include('confirmable_id')
    end
  end
end
