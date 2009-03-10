class RenameProviderToHealthcareProvider < ActiveRecord::Migration
  def self.up
    rename_table :providers, :healthcare_providers
    rename_column :appointments, :provider_id, :healthcare_provider_id
  end

  def self.down
    rename_table :healthcare_providers, :providers
    rename_column :appointments, :healthcare_provider_id, :provider_id
  end
end
