class AddCreatedOnToTables < ActiveRecord::Migration
  def self.up
    add_column :appointments, :created_on, :datetime
    add_column :healthcare_providers, :created_on, :datetime
    add_column :patients, :created_on, :datetime
  end

  def self.down
    remove_column :appointments, :created_on
    remove_column :healthcare_providers, :created_on
    remove_column :patients, :created_on
  end
end
