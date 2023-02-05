class CreateTransplantGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :transplant_guides do |t|
      t.string :plant_type
      t.string :growth_habit
      t.string :spacing
      t.string :depth
      t.string :recommended_tools
      t.string :sun_requirements
      t.string :description
      t.references :plant_coach_guide, foreign_key: true

      t.timestamps
    end
  end
end
