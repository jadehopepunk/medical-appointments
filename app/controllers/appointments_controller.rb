class AppointmentsController < ApplicationController
  # Configuration
  @@start_hour = 8
  @@end_hour = 18
  @@default_column_count = 5

  before_filter :load_first_minute
    
  def index
    begin
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    rescue ArgumentError
      @date = Date.today
    end
    
    @times = (@@start_hour..(@@end_hour - 1)).collect {|h| @date.to_time + h.hours}
    
    @providers = HealthcareProvider.find(:all, :order => 'name')

    num_columns = (@providers.length < @@default_column_count ? @providers.length : @@default_column_count)    
    @columns = (0..(num_columns - 1)).collect { |index| column_for_provider(@providers[index], @date, index) }
  end
  
  def index_for_provider
    @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @provider = HealthcareProvider.find(params[:provider_id])    
    @column = column_for_provider(@provider, @date)
    
    render :layout => false
  end
  
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
  end
  
  def new
    @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @minute = params[:minute].to_i
    
    @appointment = Appointment.new
    @appointment.healthcare_provider = HealthcareProvider.find(params[:provider_id])
    @appointment.start_time = @date.to_time + @minute.minutes

    render :layout => false
  end
  
  def create
    @appointment = Appointment.new(params[:appointment])
    if @appointment.valid?
      @saved = true
      @appointment.create
    end
  end
  
  def edit
    @appointment = Appointment.find(params[:id])
    render :layout => false
  end
  
  def update
    @appointment = Appointment.find(params[:id])
    @saved = @appointment.update_attributes(params[:appointment])
  end
  
  def update_in_place
    @appointment = Appointment.find(params[:id])
    @saved = @appointment.update_attributes(params[:appointment])
  end
  
private

  def column_for_provider(provider, date, index = nil)
    {
      :index => index, 
      :provider => provider,
      :appointments => provider.appointments_on(date),
      :slots => TimeSlot.range(@@start_hour * 60, @@end_hour * 60, provider.default_appointment_duration)
    }
  end
    
  def load_first_minute
    @first_minute = @@start_hour.hours / 60
    true
  end
  
end
