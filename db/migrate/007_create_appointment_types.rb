class CreateAppointmentTypes < ActiveRecord::Migration
  def self.up
    create_table :appointment_types do |t|
      t.column :name, :string
      t.column :duration, :integer
      t.column :healthcare_provider_id, :integer
    end
  end

  def self.down
    drop_table :appointment_types
  end
end
