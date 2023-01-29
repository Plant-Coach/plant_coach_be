class AddDirectSeedRecommendationToGardenPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :direct_seed_recommendation, :integer, default: 0
  end
end
