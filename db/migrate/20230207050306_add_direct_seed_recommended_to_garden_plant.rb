class AddDirectSeedRecommendedToGardenPlant < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :direct_seed_recommended, :boolean, null: false
  end
end
