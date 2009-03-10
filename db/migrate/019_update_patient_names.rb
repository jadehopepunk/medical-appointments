class UpdatePatientNames < ActiveRecord::Migration
  def self.up
    for patient in Patient.find(:all)
      patient.save
    end
  end

  def self.down
  end
end
