class AddElementsToGardenPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :garden_plants, :planting_status, :integer, null: false, default: 0
    add_column :garden_plants, :start_from_seed, :boolean, null: false, default: false
    add_column :garden_plants, :recommended_seed_sewing_date, :date
    add_column :garden_plants, :actual_seed_sewing_date, :date
    add_column :garden_plants, :seedling_days_to_transplant, :date
  end
end
