class DropPlantCoachGuide < ActiveRecord::Migration[5.2]
  def change
    drop_table :plant_coach_guides
  end
end
