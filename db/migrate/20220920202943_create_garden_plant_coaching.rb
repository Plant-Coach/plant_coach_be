class CreateGardenPlantCoaching < ActiveRecord::Migration[5.2]
  def change
    create_table :garden_plant_coachings do |t|
      t.string :title
      t.string :description
      t.integer :days_to_remind

      t.timestamps
    end
  end
end
