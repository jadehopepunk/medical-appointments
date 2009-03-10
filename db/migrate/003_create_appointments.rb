class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.column :patient_id, :integer
      t.column :start_time, :datetime
      t.column :duration, :integer
      t.column :comment, :text
    end
  end

  def self.down
    drop_table :appointments
  end
end
