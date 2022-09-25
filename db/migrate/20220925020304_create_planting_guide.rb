class CreatePlantingGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :planting_guides do |t|
      t.string :plant_type
      t.string :description

      t.timestamps
    end
  end
end
