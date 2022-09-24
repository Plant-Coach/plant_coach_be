class CreateGardenUserCoaching < ActiveRecord::Migration[5.2]
  def change
    create_table :garden_user_coachings do |t|
      t.references :user, foreign_key: true
      t.references :garden_coaching, foreign_key: true

      t.timestamps
    end
  end
end
