class RemoveDirectSeedRecommendation < ActiveRecord::Migration[5.2]
  def change
    remove_column :garden_plants, :direct_seed_recommendation
    remove_column :seed_default_data, :direct_seed_recommendation
  end
end
