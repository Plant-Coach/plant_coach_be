class RemoveStartFromSeedFromGardenPlants < ActiveRecord::Migration[7.0]
  def change
    remove_column :garden_plants, :start_from_seed
  end
end
