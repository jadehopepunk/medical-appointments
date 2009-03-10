class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :healthcare_provider
  belongs_to :appointment_type
  belongs_to :state, :class_name => 'AppointmentState', :foreign_key => 'appointment_state_id'
  has_and_belongs_to_many :categories, :class_name => 'AppointmentCategory'
  
  validates_presence_of :state, :patient, :healthcare_provider, :start_time, :appointment_type
  validate :provider_is_available
  
  before_validation :update_end_time
  
  def initialize(attributes = nil)
    state = AppointmentState.default
    super(attributes)
  end
  
  def label
    patient.nil? ? 'new' : patient.name
  end
  
  def start_minute
    unless start_time.nil?
      start_time.hour * 60 + start_time.min
    end
  end
  
  alias_method :original_healthcare_provider=, :healthcare_provider=
  
  def healthcare_provider=(provider)
    self.appointment_type = (provider.nil? ? nil : provider.default_appointment_type)
    self.original_healthcare_provider = provider
  end
  
  def duration
    !duration_override.blank? ? duration_override : appointment_type.duration
  end
  
  def patient_name
    patient.name unless patient.nil?
  end
  
  def patient_name=(value)
    self.patient = Patient.find(:first, :conditions => ["name = ?", value])
  end
  
  def category_ids=(category_id_array)
    self.categories = category_id_array.reject{ |category_id| category_id == '' }.collect { |category_id| AppointmentCategory.find(category_id.to_i) }
  end
  
protected

  def provider_is_available
    if !healthcare_provider.nil? && !start_time.nil? && !duration.nil? && !healthcare_provider.is_available_between(start_time, end_time, id)
      errors.add(:start_time, "and Duration clash with another appointment for this Healthcare Provider.")
    end
  end
  
  def update_end_time
    unless start_time.nil? || duration.nil?
      self.end_time = start_time + duration.minutes
    end
  end
  
end
