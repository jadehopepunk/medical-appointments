class RenameAppointmentDuration < ActiveRecord::Migration
  def self.up
    rename_column :appointments, :duration, :duration_override
  end

  def self.down
    rename_column :appointments, :duration_override, :duration
  end
end
