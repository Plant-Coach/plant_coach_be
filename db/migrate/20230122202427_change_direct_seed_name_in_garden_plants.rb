class ChangeDirectSeedNameInGardenPlants < ActiveRecord::Migration[5.2]
  def change
    rename_column :garden_plants, :direct_seed, :direct_seed_recommendation
  end
end
