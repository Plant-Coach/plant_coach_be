class AddOrganicToPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :organic, :boolean, null: false, default: false
  end
end
