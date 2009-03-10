class AddProviderToAppointments < ActiveRecord::Migration
  def self.up
    add_column :appointments, :provider_id, :integer
  end

  def self.down
    remove_column :appointments, :provider_id
  end
end
