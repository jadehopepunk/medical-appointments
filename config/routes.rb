ActionController::Routing::Routes.draw do |map|
  
  UJS::routes

  map.connect '', :controller => 'appointments', :action => 'index', :year => Date.today.year, :month => Date.today.month, :day => Date.today.day

  map.connection 'appointments/:action/:year/:month/:day', 
                 :controller => 'appointments', 
                 :requirements => { :action => /(index|index_for_provider|new)/,
                                    :year => /(19|20)\d\d/, 
                                    :month => /[01]?\d/, 
                                    :day => /[0-3]?\d/}
                                     
  map.connection ':controller/:action/:id'
                  

end
