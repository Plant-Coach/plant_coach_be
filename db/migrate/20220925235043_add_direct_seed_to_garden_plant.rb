class AddDirectSeedToGardenPlant < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :direct_seed, :boolean
  end
end
