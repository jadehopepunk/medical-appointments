class AddDefaultAppointmentTypeToProviders < ActiveRecord::Migration
  def self.up
    add_column :healthcare_providers, :default_appointment_type_id, :integer
  end

  def self.down
    remove_column :healthcare_providers, :default_appointment_type_id
  end
end
