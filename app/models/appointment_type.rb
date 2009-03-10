class AppointmentType < ActiveRecord::Base
  belongs_to :healthcare_provider
  validates_presence_of :healthcare_provider, :duration
  
  
end
