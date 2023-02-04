class DropGardenUserCoaching < ActiveRecord::Migration[5.2]
  def change
    drop_table :garden_user_coachings
  end
end
