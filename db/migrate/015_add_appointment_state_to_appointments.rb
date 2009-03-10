class AddAppointmentStateToAppointments < ActiveRecord::Migration
  def self.up
    add_column :appointments, :appointment_state_id, :integer
  end

  def self.down
    remove_column :appointments, :appointment_state_id
  end
end
