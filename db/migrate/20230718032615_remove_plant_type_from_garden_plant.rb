class RemovePlantTypeFromGardenPlant < ActiveRecord::Migration[5.2]
  def change
    remove_column :garden_plants, :plant_type
  end
end
