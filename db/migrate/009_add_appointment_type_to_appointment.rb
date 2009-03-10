class AddAppointmentTypeToAppointment < ActiveRecord::Migration
  def self.up
    add_column :appointments, :appointment_type_id, :integer
  end

  def self.down
    remove_column :appointments, :appointment_type_id
  end
end
