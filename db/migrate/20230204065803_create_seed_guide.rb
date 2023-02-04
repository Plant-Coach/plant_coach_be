class CreateSeedGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :seed_guides do |t|
      t.integer :germination_temp
      t.integer :growing_temp
      t.text :equipment_needed
      t.string :description
      t.string :sewing_depth
      t.string :when_ready_for_transplant
      t.boolean :needs_fertilization
      t.integer :fertilization_frequency
      t.boolean :direct_seed_recommended
      t.boolean :recommended_transplant_date
      t.boolean :recommended_seed_start_date
      t.boolean :needs_potting_up
      t.string :potting_up_advice

      t.timestamps
    end
  end
end
