class CreateTransplantGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :transplant_guides do |t|
      t.string :plant_type
      t.integer :days_to_maturity
      t.integer :days_relative_to_frost_date
      t.references :plant_coach_guide, foreign_key: true

      t.timestamps
    end
  end
end
