class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.column :first_name, :string
      t.column :surname, :string
    end
  end

  def self.down
    drop_table :patients
  end
end
