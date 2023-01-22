class AddDirectSeedRecommendationToSeedDefaultData < ActiveRecord::Migration[5.2]
  def change
    add_column :seed_default_data, :direct_seed_recommendation, :integer, default: 0
  end
end
