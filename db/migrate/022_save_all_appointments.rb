class SaveAllAppointments < ActiveRecord::Migration
  def self.up
    for appointment in Appointment.find(:all)
      appointment.save!
    end
  end

  def self.down
  end
end
