class DropTransplantCoachings < ActiveRecord::Migration[5.2]
  def change
    drop_table :transplant_coachings
  end
end
