class AddPlantTypeToPlant < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :plant_type, :string
  end
end
