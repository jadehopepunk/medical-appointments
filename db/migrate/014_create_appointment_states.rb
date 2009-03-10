class CreateAppointmentStates < ActiveRecord::Migration
  def self.up
    create_table :appointment_states do |t|
      t.column :name, :string
      t.column :icon, :string
      t.column :colour, :string
    end
  end

  def self.down
    drop_table :appointment_states
  end
end
