class AddDirectSeedRecommendedToSeedDefaultData < ActiveRecord::Migration[5.2]
  def change
    add_column :seed_default_data, :direct_seed_recommended, :boolean, null: false
  end
end
