class Patient < ActiveRecord::Base
  
  validates_presence_of :first_name, :surname
  before_save :update_name
  
  def name
    first_name.to_s + ' ' + surname.to_s
  end
  
private

  def update_name
    self.name = name
  end
  
end
