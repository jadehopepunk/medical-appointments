class RemoveDefaultAppointmentDuration < ActiveRecord::Migration
  def self.up
    remove_column :healthcare_providers, :default_appointment_length
  end

  def self.down
    add_column :healthcare_providers, :default_appointment_length, :integer
  end
end
