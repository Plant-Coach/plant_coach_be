class AddFromSeedToUserPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :user_plants, :from_seed, :boolean
  end
end
