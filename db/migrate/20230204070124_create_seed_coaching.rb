class CreateSeedCoaching < ActiveRecord::Migration[5.2]
  def change
    create_table :seed_coachings do |t|
      t.date :when_to_remind
      t.boolean :remind
      t.references :seed_guide, foreign_key: true
      t.references :garden_plant, foreign_key: true

      t.timestamps
    end
  end
end
