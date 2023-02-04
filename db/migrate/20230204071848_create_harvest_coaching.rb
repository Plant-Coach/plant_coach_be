class CreateHarvestCoaching < ActiveRecord::Migration[5.2]
  def change
    create_table :harvest_coachings do |t|
      t.references :harvest_guide, foreign_key: true
      t.references :garden_plant, foreign_key: true
    end
  end
end
