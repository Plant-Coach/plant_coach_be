class CreateGardenPlantAction < ActiveRecord::Migration[5.2]
  def change
    create_table :garden_plant_actions do |t|
      t.references :garden_plant, foreign_key: true
      t.references :garden_plant_coaching, foreign_key: true
    end
  end
end
