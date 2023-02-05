class CreatePlantCoachGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :plant_coach_guides do |t|
      t.string :plant_type

      t.timestamps
    end
  end
end
