class CreateAppointmentCategories < ActiveRecord::Migration
  def self.up
    create_table :appointment_categories do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :appointment_categories
  end
end
