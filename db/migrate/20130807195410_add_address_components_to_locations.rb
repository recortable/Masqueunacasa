class AddAddressComponentsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :country, :string
    add_column :locations, :region, :string
    add_column :locations, :locality, :string
    add_column :locations, :address, :string
    add_column :locations, :normalized_address, :string
  end
end
