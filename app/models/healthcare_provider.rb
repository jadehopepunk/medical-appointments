class HealthcareProvider < ActiveRecord::Base
  has_many :appointments
  has_many :appointment_types
  belongs_to :default_appointment_type, :class_name => 'AppointmentType', :foreign_key => 'default_appointment_type_id'
  
  validates_presence_of :name, :default_appointment_type

  def appointments_on(date)
    appointments.find(:all, :order => 'start_time ASC', :conditions => ["start_time >= ? and start_time < ?", date.to_time.beginning_of_day, date.to_time.beginning_of_day.tomorrow])
  end
  
  def create_default_appointment_types
    appointment_types = []
    appointment_types << AppointmentType.create(:name => 'A', :duration => 5, :healthcare_provider => self)
    appointment_types << AppointmentType.create(:name => 'B', :duration => 20, :healthcare_provider => self)
    appointment_types << AppointmentType.create(:name => 'C', :duration => 40, :healthcare_provider => self)
    appointment_types << AppointmentType.create(:name => 'D', :duration => 60, :healthcare_provider => self)
    default_appointment_type = appointment_types[1]
    save!
  end
  
  def default_appointment_duration
    default_appointment_type.duration
  end
  
  def is_available_between(start_time, end_time, exception_id)
    appointments.find(:first, :conditions => ["id != ? AND ((start_time >= ? AND start_time < ?) OR (end_time > ? AND end_time <= ?) OR (start_time <= ? AND end_time >= ?))", exception_id, start_time, end_time, start_time, end_time, start_time, end_time]).nil?
  end
  
end
