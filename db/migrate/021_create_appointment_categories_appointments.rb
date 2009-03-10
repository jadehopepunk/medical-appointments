class CreateAppointmentCategoriesAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointment_categories_appointments, :id => false do |t|
      t.column :appointment_category_id, :integer
      t.column :appointment_id, :integer
    end    
  end

  def self.down
    drop_table :appointment_categories_appointments
  end
end
