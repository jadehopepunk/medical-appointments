class AddDefaultAppointmentLengthToProviders < ActiveRecord::Migration
  def self.up
    add_column :providers, :default_appointment_length, :integer, :null => false, :default => 30
  end

  def self.down
    remove_column :providers, :default_appointment_length
  end
end
