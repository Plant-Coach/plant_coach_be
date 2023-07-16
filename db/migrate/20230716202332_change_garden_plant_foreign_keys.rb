class ChangeGardenPlantForeignKeys < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :garden_plants, :users
  end
end
