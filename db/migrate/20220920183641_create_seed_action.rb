class CreateSeedAction < ActiveRecord::Migration[5.2]
  def change
    create_table :seed_actions do |t|
      t.references :garden_plant, foreign_key: true
      t.references :seed_coaching, foreign_key: true

      t.timestamps
    end
  end
end
