
class TimeSlot
  include Reloadable
  
  def self.range(start_minute, end_minute, duration)
    results = []
    
    slot = TimeSlot.new(start_minute, duration)
    while slot.end_minute <= end_minute
      results << slot
      slot = TimeSlot.new(slot.end_minute, duration)
    end
    results
  end
  
  def initialize(start_minute, duration)
    @start_minute = start_minute
    @duration = duration
  end  
  
  attr_accessor :start_minute, :duration
  
  def end_minute
    start_minute + duration
  end
  
  def start_time
    Time.new.midnight + start_minute * 60
  end
  
end