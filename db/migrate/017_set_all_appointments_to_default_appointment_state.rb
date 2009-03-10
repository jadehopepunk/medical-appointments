class SetAllAppointmentsToDefaultAppointmentState < ActiveRecord::Migration
  def self.up
    execute "UPDATE appointments SET appointment_state_id = 1"
  end

  def self.down
    execute "UPDATE appointments SET appointment_state_id = NULL"
  end
end
