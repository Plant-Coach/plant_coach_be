class AddPlantRefToGardenPlants < ActiveRecord::Migration[5.2]
  def change
    add_reference :garden_plants, :plant, foreign_key: true
  end
end
