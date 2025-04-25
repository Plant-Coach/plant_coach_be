class AddHybridStatusToGardenPlant < ActiveRecord::Migration[7.2]
  def change
    add_column :garden_plants, :hybrid_status, :integer
  end
end
