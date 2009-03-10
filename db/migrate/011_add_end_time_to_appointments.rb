class AddEndTimeToAppointments < ActiveRecord::Migration
  def self.up
    add_column :appointments, :end_time, :datetime
  end

  def self.down
    remove_column :appointments, :end_time
  end
end
