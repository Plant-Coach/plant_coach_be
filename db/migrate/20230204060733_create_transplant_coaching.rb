class CreateTransplantCoaching < ActiveRecord::Migration[5.2]
  def change
    create_table :transplant_coachings do |t|
      t.date :when_to_remind
      t.boolean :remind
      t.references :transplant_guide, foreign_key: true
      t.references :garden_plant, foreign_key: true

      t.timestamps
    end
  end
end
