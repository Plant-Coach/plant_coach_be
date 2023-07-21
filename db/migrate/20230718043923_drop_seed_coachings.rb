class DropSeedCoachings < ActiveRecord::Migration[5.2]
  def change
    drop_table :seed_coachings
  end
end
