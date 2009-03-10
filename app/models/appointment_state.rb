class AppointmentState < ActiveRecord::Base

  def self.default
    AppointmentState.find(1)
  end

end
