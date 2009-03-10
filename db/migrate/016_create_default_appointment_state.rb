class CreateDefaultAppointmentState < ActiveRecord::Migration
  def self.up
    AppointmentState.create(:name => 'Booked', :icon => 'booked.png', :colour => '#FFCC99')
  end

  def self.down
    AppointmentState.destroy_all(:conditions => "name = 'Booked'")
  end
end
