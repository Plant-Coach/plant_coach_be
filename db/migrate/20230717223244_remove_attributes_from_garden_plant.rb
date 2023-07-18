class RemoveAttributesFromGardenPlant < ActiveRecord::Migration[5.2]
  def change
    remove_column :garden_plants, :name
    remove_column :garden_plants, :days_to_maturity
    remove_column :garden_plants, :hybrid_status
    remove_column :garden_plants, :days_relative_to_frost_date
    remove_column :garden_plants, :organic
  end
end
