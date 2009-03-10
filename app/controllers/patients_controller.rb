class PatientsController < ApplicationController
  
  auto_complete_for :patient, :name
  
end
