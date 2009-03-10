module AppointmentsHelper
  
  def format_time(time)
    twelve_hour = time.hour % 12
    twelve_hour = 12 if twelve_hour == 0
    time.strftime("#{twelve_hour}:%M %p").downcase
  end
  
  def day_url(date)
    url_for :controller => 'appointments', :action => 'index', :year => date.year, :month => date.mon, :day => date.day
  end
  
  
end
