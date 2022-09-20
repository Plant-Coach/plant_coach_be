class CreateSeedCoaching < ActiveRecord::Migration[5.2]
  def change
    create_table :seed_coachings do |t|
      t.string :title
      t.string :description
      t.integer :days_to_remind

      t.timestamps
    end
  end
end
